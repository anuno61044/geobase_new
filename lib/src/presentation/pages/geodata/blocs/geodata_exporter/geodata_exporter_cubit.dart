import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';
import 'package:path/path.dart' as path;

part 'geodata_exporter_cubit.freezed.dart';
part 'geodata_exporter_state.dart';

@injectable
class GeodataExporterCubit extends Cubit<GeodataExporterState> {
  GeodataExporterCubit(this.geodataService)
      : super(GeodataExporterState.state());

  final IGeodataService geodataService;

  Future<void> updateLoaded(List<GeodataGetEntity> geodatas) async {
    emit(state.copyWith(
      geodatas: geodatas,
      status: geodatas.isEmpty
          ? GeodataExporterStatus.NotLoaded
          : GeodataExporterStatus.FetchSuccess,
    ));
  }

  Future<void> exportGeodata() async {
    if (state.status.isLoading) return;

    try {
      if (state.geodatas.isEmpty) {
        return _exportAll();
      } else {
        return _exportLoaded();
      }
    } catch (e) {
      emit(state.copyWith(
          message: 'Error al solicitar permisos: ${e.toString()}'));
    }
  }

  Future<void> _exportLoaded() async {
    emit(state.copyWith(status: GeodataExporterStatus.ExportInProgress));
    try {
      if (state.geodatas.isEmpty) {
        emit(state.copyWith(
            status: GeodataExporterStatus.FetchSuccessNotFound,
            message: 'No hay categorías disponibles para exportar'));
        return;
      }
      final filePath = await _saveGeodataToExcel(state.geodatas);

      if (isClosed) return;
      emit(state.copyWith(
        status: GeodataExporterStatus.ExportSuccess,
        filePath: filePath ?? 'Ruta no disponible',
      ));
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(
            status: GeodataExporterStatus.ExportFailure,
            message: e.toString()));
      }
    }
  }

  Future<void> _exportAll() async {
    emit(state.copyWith(status: GeodataExporterStatus.FetchInProgress));
    final response = await geodataService.loadGeodataWhere();
    response.fold(
      (error) => emit(state.copyWith(
        status: GeodataExporterStatus.FetchFailure,
        message: error.message ?? error.toString(),
      )),
      (geodatas) => emit(state.copyWith(
          geodatas: geodatas,
          status: geodatas.isEmpty
              ? GeodataExporterStatus.FetchSuccessNotFound
              : state.status,
          message: geodatas.isEmpty ? 'No hay puntos creados.' : null)),
    );
    if (response.isLeft() ||
        state.status == GeodataExporterStatus.FetchSuccessNotFound) return;

    await _exportLoaded();
  }
}

Future<String?> _saveGeodataToExcel(List<GeodataGetEntity> geodatas) async {
  log('$geodatas');
  try {
    // Crear archivo Excel
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    // Agregar encabezados
    Set<String> allFieldNames = {};
    for (var geodata in geodatas) {
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
    for (var geodata in geodatas) {
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
        row.add(fieldMap[fieldName] ?? '');
      }

      sheet.appendRow(row);
    }

    // Guardar archivo
    final selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return '';
    }

    final filePath =
        '$selectedDirectory/Geodata_Export_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    await File(filePath).writeAsBytes(excel.encode()!);

    return filePath;
  } catch (e) {
    log('Error al guardar: $e');
    throw Exception('Error al exportar: ${e.toString()}');
  }
}
