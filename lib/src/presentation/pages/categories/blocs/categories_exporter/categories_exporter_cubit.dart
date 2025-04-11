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

  Future<void> exportToJson() async {
    // nothing to do while loading
    if (state.status.isLoading) return;

    if (state.categories.isEmpty) {
      return _exportAll();
    } else {
      return _exportLoaded();
    }
  }

  Future<void> _exportLoaded() async {
    emit(state.copyWith(status: CategoryExporterStatus.ExportInProgress));
    try {
      if (state.categories.isEmpty) {
        emit(state.copyWith(
            status: CategoryExporterStatus.FetchSuccessNotFound,
            message: 'No hay categorías disponibles para exportar'));
        return;
      }
      final filePath = await _saveCategoriesToJsonWithPicker(state.categories);

      if (isClosed) return;
      emit(state.copyWith(
        status: CategoryExporterStatus.ExportSuccess,
        filePath: filePath ?? 'Ruta no disponible',
      ));
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(
            status: CategoryExporterStatus.ExportFailure,
            message: e.toString()));
      }
    }
  }

  Future<void> _exportAll() async {
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

    await _exportLoaded();
  }

  Future<String?> _saveCategoriesToJsonWithPicker(
      List<CategoryGetEntity> categories) async {
    try {
      // 1. Convertir datos a JSON
      final jsonData = jsonEncode({
        'exportedAt': DateTime.now().toIso8601String(),
        'categories': categories.map((e) => e.toJson()).toList(),
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
}
