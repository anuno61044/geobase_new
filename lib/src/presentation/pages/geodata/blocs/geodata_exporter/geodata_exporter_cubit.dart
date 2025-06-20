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
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'geodata_exporter_cubit.freezed.dart';
part 'geodata_exporter_state.dart';

enum GeodataExportMode {
  defaultDirectory,
  manualSelection,
}

@injectable
class GeodataExporterCubit extends Cubit<GeodataExporterState> {
  GeodataExporterCubit(this.geodataService)
      : super(GeodataExporterState.state());

  final IGeodataService geodataService;

  Future<void> exportGeodataWithMode(GeodataExportMode mode) async {
    if (state.status.isLoading) return;

    try {
      if (state.geodatas.isEmpty) {
        await _exportAllWithMode(mode);
      } else {
        await _exportLoadedWithMode(mode);
      }
    } catch (e) {
      emit(state.copyWith(
        message: 'Error al exportar: ${e.toString()}',
      ));
    }
  }

  Future<void> updateLoaded(List<GeodataGetEntity> geodatas) async {
    emit(state.copyWith(
      geodatas: geodatas,
      status: geodatas.isEmpty
          ? GeodataExporterStatus.NotLoaded
          : GeodataExporterStatus.FetchSuccess,
    ));
  }

  Future<void> _exportLoadedWithMode(GeodataExportMode mode) async {
    emit(state.copyWith(status: GeodataExporterStatus.ExportInProgress));
    try {
      if (state.geodatas.isEmpty) {
        emit(state.copyWith(
          status: GeodataExporterStatus.FetchSuccessNotFound,
          message: 'No hay puntos disponibles para exportar',
        ));
        return;
      }

      String? filePath;

      switch (mode) {
        case GeodataExportMode.defaultDirectory:
          filePath = await _saveGeodataToPredefinedPath(state.geodatas);
          break;
        case GeodataExportMode.manualSelection:
          filePath = await _saveGeodataToManualPath(state.geodatas);
          break;
      }

      if (isClosed) return;
      emit(state.copyWith(status: GeodataExporterStatus.ExportSuccess, filePath: filePath));
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(
          status: GeodataExporterStatus.ExportFailure,
          message: e.toString(),
        ));
      }
    }
  }

  Future<void> _exportAllWithMode(GeodataExportMode mode) async {
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
        message: geodatas.isEmpty ? 'No hay puntos creados.' : null,
      )),
    );

    if (response.isLeft() ||
        state.status == GeodataExporterStatus.FetchSuccessNotFound) return;

    await _exportLoadedWithMode(mode);
  }
}

Future<String?> _saveGeodataToPredefinedPath(List<GeodataGetEntity> geodatas) async {
  
  final downloadsPath = await getDownloadsPath();
  if (downloadsPath == null) {
    throw Exception('No se pudo obtener la carpeta Downloads.');
  }

  final exportDir = Directory('$downloadsPath/GeobaseExport');
  if (!exportDir.existsSync()) {
    exportDir.createSync(recursive: true);
  }

  return await _saveGeodataToExcel(geodatas, exportDir.path);
}

Future<String?> getDownloadsPath() async {
  if (Platform.isAndroid) {
    // Solo Android
    final downloadsDir = Directory('/storage/emulated/0/Download');

    if (!downloadsDir.existsSync()) {
      downloadsDir.createSync(recursive: true);
    }
    return downloadsDir.path;
  }
  // iOS o otros
  return null;
}

Future<String?> _saveGeodataToManualPath(
    List<GeodataGetEntity> geodatas) async {
  final selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) return null;
  return await _saveGeodataToExcel(geodatas, selectedDirectory);
}

// Generar los encabezados del excel por hojas segun categorias y formularios
Map<String, List<String>> _buildExcelStruct(List<GeodataGetEntity> geodatas) {
  Map<String, List<String>> struct = {};

  for (final data in geodatas) {
    if (struct.containsKey(data.category.name)) continue;

    List<String> columnNames = ['Latitud', 'Longitud'];
    for (final field in data.fields) {
      columnNames.add(field.column.name);

      if (field.column.type.metaType == 'Form') {
        Map<String, List<String>> subStructure = _buildNestedFormsStruct(field);

        for (final item in subStructure.entries) {
          if (struct.containsKey(item.key)) continue;

          struct[item.key] = item.value;
        }
      }
    }
    struct[data.category.name] = columnNames;
  }

  return struct;
}

Map<String, List<String>> _buildNestedFormsStruct(
    FieldValueGetEntity fieldValueForm) {
  Map<String, List<String>> struct = {};

  if (fieldValueForm.value.length == 0) {
    return {};
  }

  // Nombred de las columnas del formulario
  List<String> columnNames = ['ID'];

  List<FieldValueGetEntity> fieldvalues = [];

  // Si es un formulario su value será una lista de String con los subformularios que el usuario haya creado serializados
  // Solo necesitamos el primero para obtener su estructura
  final val = (fieldValueForm.value as List<dynamic>).first;

  final map = json.decode(val as String) as Map<String, dynamic>;
  fieldvalues = map.values
      .map((e) => FieldValueGetEntity.fromMap(e as Map<String, dynamic>))
      .toList();

  for (final field in fieldvalues) {
    columnNames.add(field.column.name);

    if (field.column.type.metaType == 'Form') {
      Map<String, List<String>> subStructure = _buildNestedFormsStruct(field);

      for (final item in subStructure.entries) {
        if (struct.containsKey(item.key)) continue;

        struct[item.key] = item.value;
      }
    }
  }

  struct[fieldValueForm.column.type.name] = columnNames;

  return struct;
}

// Generar las filas de los datos
Map<String, List<List<String>>> _buildFormRows(
    FieldValueGetEntity fieldValueForm, String id) {
  Map<String, List<List<String>>> rowsBySheet = {};

  List<List<String>> rowsList = [];
  List<List<String>> mediasList = [];
  for (final val in fieldValueForm.value) {
    // Creamos la fila empezando con el id
    List<String> row = [id];

    final map = json.decode(val as String) as Map<String, dynamic>;

    // Obtenemos los valores de las columnas del formulario
    List<FieldValueGetEntity> fieldvalues = [];
    fieldvalues = map.values
        .map((e) => FieldValueGetEntity.fromMap(e as Map<String, dynamic>))
        .toList();

    for (final field in fieldvalues) {
      if (field.column.type.metaType == 'Form') {
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        String idValue = '${field.column.type.name}_$id';
        // Referencia añadida en la hoja principal
        row.add(idValue);

        for (final item in _buildFormRows(field, idValue).entries) {
          if (rowsBySheet.containsKey(item.key)) {
            rowsBySheet[item.key]!.addAll(item.value);
          } else {
            rowsBySheet[item.key] = item.value;
          }
        }
      } else if (field.column.type.metaType == 'Media') {
        String extension = path.extension(field.value.toString()); // .jpg
        // Asignar un nuevo nombre
        String mediaId = DateTime.now().microsecondsSinceEpoch.toString();
        String newFileName = 'media_$mediaId$extension';

        mediasList.add(['${field.value}%$newFileName']);
        row.add(newFileName);
      } else {
        row.add(field.value.toString());
      }
    }
    rowsList.add(row);
  }

  // Agregar los datos del formulario
  if (rowsBySheet.containsKey(fieldValueForm.column.type.name)) {
    rowsBySheet[fieldValueForm.column.type.name]?.addAll(rowsList);
  } else {
    rowsBySheet[fieldValueForm.column.type.name] = rowsList;
  }

  // Agregar las medias
  if (rowsBySheet.containsKey('media_files')) {
    rowsBySheet['media_files']!.addAll(mediasList);
  } else {
    rowsBySheet['media_files'] = mediasList;
  }

  return rowsBySheet;
}

// Método principal de exportación
Future<String?> _saveGeodataToExcel(
  List<GeodataGetEntity> geodatas,
  String destinationRoot,
) async {
  try {
    // Crear archivo Excel
    final excel = Excel.createExcel();
    excel.delete('Sheet1');

    List<GeodataGetEntity> onlyGeodatas = [];
    for (GeodataGetEntity item in geodatas) {
      onlyGeodatas.add(item);
    }

    Map<String, List<String>> structInExcel = _buildExcelStruct(geodatas);

    // Encabezados de las hojas de formularios
    for (final head in structInExcel.entries) {
      excel[head.key].appendRow(head.value);
    }

    // *************************
    //       Agregar datos
    // *************************
    Map<String, List<List<String>>> rowsBySheet = {};
    List<List<String>> mediasList = [];
    for (var geodata in geodatas) {
      // Valores de la columna de ese punto
      List<String> row = [
        geodata.latitude.toString(),
        geodata.longitude.toString()
      ];
      for (var field in geodata.fields) {
        if (field.column.type.metaType == 'Form') {
          String id = DateTime.now().microsecondsSinceEpoch.toString();
          String idValue = '${field.column.type.name}_$id';
          // Referencia añadida en la hoja principal
          row.add(idValue);

          // Guardar los datos del tipo Form
          for (final item in _buildFormRows(field, idValue).entries) {
            if (rowsBySheet.containsKey(item.key)) {
              rowsBySheet[item.key]!.addAll(item.value);
            } else {
              rowsBySheet[item.key] = item.value;
            }
          }
        } else if (field.column.type.metaType == 'Media') {
          String extension = path.extension(field.value.toString()); // .jpg
          // Asignar un nuevo nombre
          String mediaId = DateTime.now().microsecondsSinceEpoch.toString();
          String newFileName = 'media_$mediaId$extension';

          mediasList.add(['${field.value}%$newFileName']);
          row.add(newFileName);
        } else {
          row.add(field.value.toString());
        }
      }

      if (rowsBySheet.containsKey(geodata.category.name)) {
        rowsBySheet[geodata.category.name]!.add(row);
      } else {
        rowsBySheet[geodata.category.name] = [row];
      }
    }

    if (rowsBySheet.containsKey('media_files')) {
      rowsBySheet['media_files']!.addAll(mediasList);
    } else {
      rowsBySheet['media_files'] = mediasList;
    }

    for (final item in rowsBySheet.entries) {
      if (item.key == 'media_files') continue;
      for (final row in item.value) {
        excel[item.key].appendRow(row);
      }
    }

    final exportDir =
        '$destinationRoot/export_${DateTime.now().millisecondsSinceEpoch}';
    await Directory(exportDir).create(recursive: true);
    await Directory('$exportDir/medias').create(recursive: true);

    for (final media in rowsBySheet['media_files']!) {
      String originalFilePath = media[0].substring(0, media[0].indexOf('%'));
      String newFileName = media[0].substring(media[0].indexOf('%') + 1);

      // Copiar el archivo
      await File(originalFilePath).copy('$exportDir/medias/$newFileName');
    }

    // Guardar archivo
    final filePath = '$exportDir/Geodata.xlsx';
    await File(filePath).writeAsBytes(excel.encode()!);
    return filePath;
  } catch (e) {
    log('Error al guardar: $e');
    throw Exception('Error al exportar: ${e.toString()}');
  }
}
