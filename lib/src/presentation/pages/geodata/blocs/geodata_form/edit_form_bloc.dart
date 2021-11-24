import 'package:dartz/dartz.dart';
import 'package:flutter_lyform/flutter_lyform.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart';
import 'package:geobase/src/presentation/pages/geodata/blocs/blocs.dart';

abstract class IGeodataEditFormBloc extends IGeodataFormBloc {
  InputBloc<int> get geodataId;

  GeodataGetEntity get defaultData;

  @override
  List<InputBloc> get inputs => [
        geodataId,
        categoryId,
        latitude,
        longitude,
        ...fieldValues.values,
      ];
}

@Injectable(as: IGeodataEditFormBloc)
class GeodataEditFormBloc extends IGeodataEditFormBloc {
  GeodataEditFormBloc({
    required this.geodataService,
    @factoryParam GeodataEditInitialData? editInitialData,
  })  : initialData = editInitialData!,
        super();

  final IGeodataService geodataService;
  final GeodataEditInitialData initialData;

  @override
  CategoryGetEntity get category => initialData.data.category;

  @override
  GeodataGetEntity get defaultData => initialData.data;

  @override
  late final InputBloc<int> categoryId = InputBloc(
    pureValue: category.id,
  );

  @override
  late final InputBloc<int> geodataId = InputBloc(
    pureValue: defaultData.id,
  );

  @override
  late final InputBloc<String> latitude = InputBloc<String>(
    pureValue: defaultData.location.latitude.toString(),
  );

  @override
  late final InputBloc<String> longitude = InputBloc<String>(
    pureValue: defaultData.location.longitude.toString(),
  );

  @override
  late final Map<ColumnGetEntity, InputBloc<FieldValuePutEntity>> fieldValues =
      Map.fromEntries(
    defaultData.fields.map(
      (e) => MapEntry(
        e.column,
        (FieldRenderResolver.getInputBloc(
          e.column,
          FieldValuePutEntity(
            id: e.id,
            geodataId: e.geodataId,
            value: e.value,
            columnId: e.id,
          ),
        ) as InputBloc<FieldValuePutEntity>?)!,
      ),
    ),
  );

  @override
  Future<FormBlocState<Unit, Failure>> onSubmmit() async {
    final response = await geodataService.editGeodata(
      GeodataPutEntity(
        id: geodataId.state.value,
        categoryId: categoryId.state.value,
        latitude: double.parse(latitude.state.value),
        longitude: double.parse(longitude.state.value),
        fieldValues:
            fieldValues.values.map((value) => value.state.value).toList(),
      ),
    );
    return response.fold(
      (error) => FormErrorState(error),
      (_) => const FormSuccessState(unit),
    );
  }
}
