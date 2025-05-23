import 'dart:convert';
import 'dart:developer';

import 'package:geobase/injection.dart';
import 'package:geobase/src/infrastructure/models/models.dart';
import 'package:geobase/src/infrastructure/providers/interfaces/interfaces.dart';
import 'package:geobase/src/infrastructure/providers/sqlite/db_model.dart';

@LazySingleton(as: IFieldValueProvider)
class FieldValueSQLiteProvider implements IFieldValueProvider {
  @override
  Future<int> create(FieldValuePostModel model) async {
    if (model.geodataId == null) {
      throw Exception("Create FieldValue Denied (geodataId can't be null)");
    }
    final id = await FieldValueDBModel.withFields(
      encodeValue(model.value),
      model.geodataId,
      model.columnId,
    ).save();
    return id!;
  }

  @override
  Future<int> edit(FieldValuePutModel model) async {
    await FieldValueDBModel.withId(
      model.id,
      encodeValue(model.value),
      model.geodataId,
      model.columnId,
    ).save();
    return model.id;
  }

  @override
  Future<List<FieldValueGetModel>> getAllFromGeodata(int geodataId) async {
    final fields = await FieldValueDBModel()
        .select()
        .geodata_id
        .equals(geodataId)
        .toList();
    final result = <FieldValueGetModel>[];
    for (FieldValueDBModel field in fields) {
      try {
        ColumnGetModel column = await getIt<IColumnsProvider>().getById(field.column_id!);
        if (column.formId != null) {
          continue;
        }

        result.add(
          FieldValueGetModel(
            value: decodeValue(field.value),
            id: field.field_value_id!,
            geodataId: geodataId,
            column: await _processColumnWithExtraData(column),
          ),
        );
      }
      catch (e) {
        log('Erroooor: $e');
      }

      
    }
    return result;
  }

  @override
  Future<FieldValueGetModel> getById(int id) async {
    final field =
        await FieldValueDBModel().select().field_value_id.equals(id).toSingle();
    if (field == null) throw Exception('FieldValue Not Found');

    ColumnGetModel column = await getIt<IColumnsProvider>().getById(field.column_id!);

    return FieldValueGetModel(
      value: decodeValue(field.value),
      id: field.field_value_id!,
      geodataId: field.geodata_id!,
      column: await _processColumnWithExtraData(column),
    );
  }

  @override
  Future<void> remove(int id) async {
    final result =
        await FieldValueDBModel().select().field_value_id.equals(id).delete();
    if (result.errorMessage?.isNotEmpty ?? false) {
      throw Exception(result.errorMessage);
    }
  }
  
  // Método interno para procesar una columna y agregar datos de formulario si es necesario
  Future<ColumnGetModel> _processColumnWithExtraData(
      ColumnGetModel column) async {
    if (column.type.metaType == 'Form') {
      final associatedColumns =
          await getIt<IColumnsProvider>().getAllFromForm(column.type.id);

      List<Map<String, dynamic>> columns =
          associatedColumns.map((col) => col.toMap()).toList();

      final modifiedColumn = ColumnGetModel(
          id: column.id,
          name: column.name,
          type: FieldTypeGetModel(
            name: column.type.name,
            renderClass: column.type.renderClass,
            id: column.type.id,
            metaType: column.type.metaType,
            extradata: {...?column.type.extradata, 'columns': columns},
          ));
      return modifiedColumn;
    }
    return column;
  }

  dynamic decodeValue(String? valueStr) =>
      valueStr != null ? json.decode(valueStr)['value'] : null;
  String encodeValue(dynamic value) => json.encode({'value': value});
}
