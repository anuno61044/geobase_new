import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

part 'geodatalist_event.dart';
part 'geodatalist_state.dart';
part 'geodatalist_bloc.freezed.dart';

@injectable
class GeodataListBloc extends Bloc<GeodataListEvent, GeodataListState> {
  GeodataListBloc(this.geodataService)
      : super(const GeodataListState.initial()) {
    on<GeodataListEvent>(
      (event, emit) async {
        await event.when(
          fetched: (categoryId) async {
            if (categoryId == null) {
              emit(const GeodataListState.initial());
              return;
            }
            emit(const GeodataListState.fetchInProgress());
            final response = await geodataService.loadGeodataWhere(
              FilterDataOptionsEntity(categoryId: categoryId),
            );
            response.fold(
              (error) => emit(
                GeodataListState.fetchFailure(
                  error: error.message ?? error.toString(),
                ),
              ),
              (geodataList) => emit(
                geodataList.isEmpty
                    ? const GeodataListState.fetchSuccessNotFound()
                    : GeodataListState.fetchSuccess(geodataList: geodataList),
              ),
            );
          },
          exportData: () async {
            emit(const GeodataListState.exportInProgress());

            final response = await geodataService.loadGeodataWhere(
              FilterDataOptionsEntity(),
            );

            await response.fold(
              (error) async {
                emit(GeodataListState.exportFailure(
                  error: error.message ?? error.toString(),
                ));
              },
              (geodataList) async {
                if (geodataList.isEmpty) {
                  emit(const GeodataListState.fetchSuccessNotFound());
                  return;
                }

                try {
                  // Crear archivo Excel
                  final excel = Excel.createExcel();
                  final sheet = excel[excel.getDefaultSheet()!];

                  // Agregar encabezados
                  Set<String> allFieldNames = {};
                  for (var geodata in geodataList) {
                    for (var field in geodata.fields) {
                      allFieldNames.add(field.column.name);
                    }
                  }

                  List<String> columnNames = [
                    'ID',
                    'Categoría',
                    'Latitud',
                    'Longitud',
                    ...allFieldNames // Ordenar alfabéticamente
                  ];
                  sheet.appendRow(columnNames);

                  // Agregar datos
                  for (var geodata in geodataList) {
                    // Crear mapa de campos para acceso rápido
                    final fieldMap = {
                      for (var field in geodata.fields)
                        field.column.name: field.value.toString()
                    };

                    // Construir fila con datos base
                    List<String> row = [
                      geodata.id.toString(),
                      geodata.category.name.toString(),
                      geodata.latitude.toString(),
                      geodata.longitude.toString(),
                    ];

                    // Agregar valores de campos dinámicos (en el mismo orden que los encabezados)
                    for (var fieldName in allFieldNames) {
                      row.add(fieldMap[fieldName] ??
                          ''); // Usar cadena vacía si el campo no existe
                    }

                    sheet.appendRow(row);
                  }

                  // Guardar archivo
                  final selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                  if (selectedDirectory == null) {
                    emit(const GeodataListState.exportFailure(
                      error: 'Selección de carpeta cancelada',
                    ));
                    return;
                  }

                  final filePath =
                      '$selectedDirectory/Geodata_Export_${DateTime.now().millisecondsSinceEpoch}.xlsx';
                  await File(filePath).writeAsBytes(excel.encode()!);

                  emit(GeodataListState.exportSuccess(filePath: filePath));
                } catch (e) {
                  emit(GeodataListState.exportFailure(
                    error: 'Error al exportar: ${e.toString()}',
                  ));
                }
              },
            );
          },
        );
      },
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(seconds: 1)).flatMap(mapper);
      },
    );
  }

  final IGeodataService geodataService;
}
