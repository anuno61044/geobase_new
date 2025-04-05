import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

part 'categorylist_bloc.freezed.dart';
part 'categorylist_event.dart';
part 'categorylist_state.dart';

@injectable
class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc(this.categoryService)
      : super(const CategoryListState.initial()) {
    on<CategoryListEvent>(
      (event, emit) async {
        await event.when(
          fetched: (query) => _handleFetch(emit, query),
          exportToJson: () => _handleExport(emit),
        );
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .where((_) => !isClosed)
            .asyncExpand(mapper);
      },
    );
  }

  final ICategoryService categoryService;

  /// Método privado para manejar la carga de categorías
  Future<void> _handleFetch(Emitter<CategoryListState> emit, String query) async {
    if (isClosed) return;
    emit(const CategoryListState.fetchInProgress());

    final response = await categoryService.loadCategoriesWhere(
      FilterCategoriesOptionsEntity(nameSubstring: query),
    );

    if (isClosed) return;

    await response.fold(
      (error) async => emit(
        CategoryListState.fetchFailure(
          error: error.message ?? error.toString(),
        ),
      ),
      (categories) async => emit(
        categories.isEmpty
            ? const CategoryListState.fetchSuccessNotFound()
            : CategoryListState.fetchSuccess(categories: categories),
      ),
    );
  }

  /// Método privado para manejar la exportación
  Future<void> _handleExport(Emitter<CategoryListState> emit) async {
    try {
      if (isClosed) return;
      emit(const CategoryListState.exportInProgress());

      // Si no hay categorías o el estado no es el correcto, intentamos cargarlas
      final currentState = state;
      if (currentState is! _FetchSuccess || currentState.categories.isEmpty) {
        await _handleFetch(emit, ''); // Cargamos todas las categorías
        
        // Verificamos nuevamente después de cargar
        final newState = state;
        if (newState is! _FetchSuccess || newState.categories.isEmpty) {
          if (isClosed) return;
          emit(const CategoryListState.exportFailure(
              error: 'No hay categorías disponibles para exportar'));
          return;
        }
      }

      // Procedemos con la exportación
      final categories = (state as _FetchSuccess).categories;
      final filePath = await _saveCategoriesToJsonWithPicker(categories);
      
      if (isClosed) return;
      emit(CategoryListState.exportSuccess(
          filePath: filePath ?? 'Ruta no disponible'));
    } catch (e) {
      if (!isClosed) {
        emit(CategoryListState.exportFailure(error: e.toString()));
      }
    }
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
