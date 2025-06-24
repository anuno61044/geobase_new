import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/core/extensions/extensions.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/entities/imported_geodata_point.dart';
import 'package:geobase/src/domain/services/imported_geodata_storage_service.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'imported_geodata_state.dart';
part 'imported_geodata_cubit.freezed.dart';

@injectable
class ImportedGeodataCubit extends Cubit<ImportedGeodataState> {
  ImportedGeodataCubit(
    this._storageService,
    this._categoryService,
  ) : super(const ImportedGeodataState.initial()) {
    _loadPersistedPoints();
  }

  final IImportedGeodataStorageService _storageService;
  final ICategoryService _categoryService;

  Future<void> _loadPersistedPoints() async {
    emit(const ImportedGeodataState.loading());
    try {
      final points = await _storageService.loadImportedPoints();
      emit(ImportedGeodataState.loaded(points));
    } catch (e) {
      emit(ImportedGeodataState.error(
          'Error al cargar puntos: ${e.toString()}'));
    }
  }

  Future<void> importPoints() async {
    emit(const ImportedGeodataState.loading());

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        await _loadPersistedPoints();
        return;
      }

      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final jsonData = json.decode(content);

      if (jsonData is! List) {
        emit(const ImportedGeodataState.error(
            'El JSON debe ser una lista de objetos.'));
        return;
      }

      final categories = await _loadCategories();

      final points = <ImportedGeodataPoint>[];

      int pointIdCounter = 1;

      for (final item in jsonData) {
        final map = item as Map<String, dynamic>;
        final point = await _parsePoint(map, categories, pointIdCounter);
        points.add(point);
        pointIdCounter++;
      }

      await _storageService.saveImportedPoints(points);
      emit(ImportedGeodataState.loaded(points));
    } catch (e) {
      emit(ImportedGeodataState.error('Error al importar: ${e.toString()}'));
    }
  }

  Future<List<CategoryGetEntity>> _loadCategories() async {
    final response = await _categoryService.loadCategoriesWhere();
    return response.fold(
      (error) => throw Exception('Error al cargar categorías'),
      (categories) => categories,
    );
  }

  Future<ImportedGeodataPoint> _parsePoint(
    Map<String, dynamic> map,
    List<CategoryGetEntity> categories,
    int pointId,
  ) async {
    final lat = (map['latitude'] ?? map['lat']) as double;
    final lng = (map['longitude'] ?? map['lng']) as double;
    final categoryName = map['category'] as String;

    final matchingCategory = categories.firstWhereOrNull(
      (c) => c.name.trim().toLowerCase() == categoryName.trim().toLowerCase(),
    );

    if (matchingCategory == null) {
      throw Exception('Categoría "$categoryName" no encontrada.');
    }

    return ImportedGeodataPoint(
      id: pointId,
      lat: lat,
      lng: lng,
      categoryId: matchingCategory.id,
    );
  }

  Future<void> removePoint(int pointId) async {
    final currentState = state;

    if (currentState is! _Loaded) return;

    // Accede a importedPoints en lugar de points
    final updatedPoints = currentState.importedPoints
        .where((point) => point.id != pointId)
        .toList();

    await _storageService.saveImportedPoints(updatedPoints);
    emit(ImportedGeodataState.loaded(updatedPoints));
  }

  Future<void> clear() async {
    await _storageService.clearImportedPoints();
    emit(const ImportedGeodataState.initial());
  }
}
