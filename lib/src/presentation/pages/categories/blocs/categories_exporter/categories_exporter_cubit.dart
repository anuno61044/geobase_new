import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/category_get_entity.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';
import 'package:path/path.dart' as path;

part 'categories_exporter_cubit.freezed.dart';
part 'categories_exporter_state.dart';

enum CategoryExportMode {
  defaultDirectory,
  manualSelection,
}

@injectable
class CategoriesExporterCubit extends Cubit<CategoriesExporterState> {
  CategoriesExporterCubit(this.categoryService)
      : super(CategoriesExporterState.state());

  final ICategoryService categoryService;

  Future<void> updateLoaded(List<CategoryGetEntity> categories) async {
    emit(state.copyWith(
      categories: categories,
      status: categories.isEmpty
          ? CategoryExporterStatus.NotLoaded
          : CategoryExporterStatus.FetchSuccess,
    ));
  }

  Future<void> exportToJson(CategoryExportMode mode) async {
    if (state.status.isLoading) return;

    emit(state.copyWith(message: null, filePath: null));

    try {
      if (state.categories.isEmpty) {
        await _exportAll(mode);
      } else {
        await _exportLoaded(mode);
      }
    } catch (e) {
      emit(state.copyWith(
          message: 'Error al exportar: ${e.toString()}',
          status: CategoryExporterStatus.ExportFailure));
    }
  }

  Future<void> _exportLoaded(CategoryExportMode mode) async {
    emit(state.copyWith(status: CategoryExporterStatus.ExportInProgress));
    try {
      if (state.categories.isEmpty) {
        emit(state.copyWith(
            status: CategoryExporterStatus.FetchSuccessNotFound,
            message: 'No hay categorías disponibles para exportar'));
        return;
      }

      String? filePath;

      switch (mode) {
        case CategoryExportMode.defaultDirectory:
          filePath =
              await _saveCategoriesToJsonAtPredefinedPath(state.categories);
          break;
        case CategoryExportMode.manualSelection:
          filePath = await _saveCategoriesToJsonWithPicker(state.categories);
          break;
      }

      emit(state.copyWith(
        status: CategoryExporterStatus.ExportSuccess,
        filePath: filePath ?? 'Ruta no disponible',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryExporterStatus.ExportFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _exportAll(CategoryExportMode mode) async {
    emit(state.copyWith(status: CategoryExporterStatus.FetchInProgress));
    final response = await categoryService.loadCategoriesWhere();
    response.fold(
      (error) => emit(state.copyWith(
        status: CategoryExporterStatus.FetchFailure,
        message: error.message ?? error.toString(),
      )),
      (categories) => emit(state.copyWith(
          categories: categories,
          status: categories.isEmpty
              ? CategoryExporterStatus.FetchSuccessNotFound
              : state.status,
          message:
              categories.isEmpty ? 'No hay categorías configuradas.' : null)),
    );

    if (response.isLeft() ||
        state.status == CategoryExporterStatus.FetchSuccessNotFound) return;

    await _exportLoaded(mode);
  }

  Future<String?> _saveCategoriesToJsonWithPicker(
      List<CategoryGetEntity> categories) async {
    try {
      // 1. Convertir datos a JSON
      final jsonData = jsonEncode({
        'exportedAt': DateTime.now().toIso8601String(),
        'categories': categories.map((e) => e.toMap()).toList(),
      });

      // 2. Pedir al usuario que seleccione una carpeta
      final String? selectedDirectory =
          await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Selecciona donde guardar el archivo',
      );

      if (selectedDirectory == null) {
        throw Exception('No se seleccionó ninguna carpeta');
      }

      // 3. Crear el nombre del archivo
      final fileName =
          'geobase_categories_${DateTime.now().millisecondsSinceEpoch}.json';
      final filePath = path.join(selectedDirectory, fileName);

      // 4. Guardar el archivo
      final file = File(filePath);
      await file.writeAsString(jsonData, flush: true);

      return filePath;
    } catch (e) {
      log('Error al guardar: $e');
      throw Exception('Error al exportar: ${e.toString()}');
    }
  }

  Future<String?> _saveCategoriesToJsonAtPredefinedPath(
      List<CategoryGetEntity> categories) async {
    try {
      final jsonData = jsonEncode({
        'exportedAt': DateTime.now().toIso8601String(),
        'categories': categories.map((e) => e.toMap()).toList(),
      });

      final predefinedDirectory = await getDownloadsPath();
      if (predefinedDirectory == null) {
        throw Exception('No se pudo obtener la carpeta Downloads.');
      }
      
      // Verifica que la carpeta existe
      final directory = Directory(predefinedDirectory);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final fileName =
          'geobase_categories_${DateTime.now().millisecondsSinceEpoch}.json';
      final filePath = path.join(predefinedDirectory, fileName);

      final file = File(filePath);
      await file.writeAsString(jsonData, flush: true);

      return filePath;
    } catch (e) {
      log('Error al guardar en ruta predefinida: $e');
      throw Exception('Error al exportar: ${e.toString()}');
    }
  }
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
