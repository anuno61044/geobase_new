import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/imported_geodata_storage_service.dart';
import 'package:geobase/src/domain/services/interfaces/interfaces.dart';
import 'package:latlong2/latlong.dart';

part 'marker_cubit.freezed.dart';
part 'marker_state.dart';

@injectable
class MarkerCubit extends Cubit<MarkerState> {
  MarkerCubit({
    required this.markerGetterService,
    required this.uPrefsReader,
    required this.importedGeodataService,
  }) : super(const MarkerState.filteredOut(
            markers: {}, importedMarkers: {}, temporalMarkers: {}));

  final IMarkerGetterService markerGetterService;
  final IUserPreferencesReaderService uPrefsReader;
  final IImportedGeodataStorageService importedGeodataService;

  Future<void> refreshMarkers({
    FilterDataOptionsEntity? filters,
    LatLng? currentCenter,
    double? zoom,
  }) async {
    FilterDataOptionsEntity? filtersToUse = filters;
    if (filtersToUse == null) {
      final eitherPrefs = await uPrefsReader.loadUserPreferences();
      eitherPrefs.fold(
        (_) => null,
        (uprefs) {
          filtersToUse = FilterDataOptionsEntity(
            categoryId: uprefs.mapMode?.categoryUsed,
          );
        },
      );
    }

    final either = await markerGetterService.getMarkers(
      filtersToUse ?? FilterDataOptionsEntity.clean(),
    );
    final Set<IMarkable> temporals = state.maybeMap(
      orElse: () => {},
      filteredOut: (state) => state.temporalMarkers,
    );

    // 1. Obtener puntos importados
    final importedPoints = await importedGeodataService.loadImportedPoints();

    // 2. Convertir a marcadores importados
    Set<ImportedGeodataMarker> importedMarkers =
        importedPoints.map((point) => ImportedGeodataMarker(point)).toSet();

    either.fold(
      (failure) {
        emit(MarkerState.failure(failure));
      },
      (entity) {
        if (isClosed) return;

        // 3. Filtrar puntos importados que coincidan con puntos normales
        final normalMarkers = entity.toSet();
        final filteredImportedMarkers = _filterDuplicateImportedMarkers(
          normalMarkers: normalMarkers,
          importedMarkers: importedMarkers,
        );

        // 4. Si hay diferencias, actualizar el almacenamiento
        if (filteredImportedMarkers.length != importedMarkers.length) {
          _updateImportedPoints(filteredImportedMarkers);
        }

        // 5. Emitir el nuevo estado
        emit(
          MarkerState.filteredOut(
            markers: normalMarkers,
            importedMarkers: filteredImportedMarkers,
            temporalMarkers: temporals,
          ),
        );
      },
    );
  }

  /// Filtra marcadores importados que coincidan en ubicación con marcadores normales
  Set<ImportedGeodataMarker> _filterDuplicateImportedMarkers({
    required Set<IMarkable> normalMarkers,
    required Set<ImportedGeodataMarker> importedMarkers,
  }) {
    return importedMarkers.where((imported) {
      // Verificar si existe un marcador normal en la misma ubicación
      return !normalMarkers.any(
          (normal) => _areLocationsEqual(normal.location, imported.location));
    }).toSet();
  }

  /// Compara dos ubicaciones con cierta tolerancia
  bool _areLocationsEqual(LatLng loc1, LatLng loc2) {
    const tolerance = 0.00001; // Aprox. 1 metro de tolerancia
    return (loc1.latitude - loc2.latitude).abs() < tolerance &&
        (loc1.longitude - loc2.longitude).abs() < tolerance;
  }

  /// Actualiza los puntos importados en el almacenamiento
  Future<void> _updateImportedPoints(
      Set<ImportedGeodataMarker> filteredMarkers) async {
    final pointsToSave = filteredMarkers.map((m) => m.point).toList();
    await importedGeodataService.saveImportedPoints(pointsToSave);
  }

  Future<void> clearTemporaryMarker() async {
    state.map(
      failure: (failure) => null,
      filteredOut: (filteredOut) {
        emit(filteredOut.copyWith(temporalMarkers: {}));
      },
    );
  }

  Future<void> clearImportedMarkers() async {
    state.map(
      failure: (_) {},
      filteredOut: (state) {
        emit(state.copyWith(importedMarkers: {}));
      },
    );
  }

  Future<void> onMapLongPress(LatLng position) async {
    state.map(
      failure: (failure) => null,
      filteredOut: (filteredOut) {
        emit(
          filteredOut.copyWith(
            temporalMarkers: {TemporalMarkerEntity(location: position)},
          ),
        );
      },
    );
  }
}
