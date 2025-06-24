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
            markers: {}, 
            importedMarkers: {}, 
            temporalMarkers: {}));
      
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

    // Puntos importados
    final importedPoints = await importedGeodataService.loadImportedPoints();
    // List<ImportedGeodataPoint> importedPoints = [];

    final importedMarkers = importedPoints
        .map((point) => ImportedGeodataMarker(point) // Usando el adaptador
            )
        .toSet();

    either.fold(
      (failure) {
        emit(MarkerState.failure(failure));
      },
      (entity) {
        if (!isClosed) {
          emit(
            MarkerState.filteredOut(
              markers: entity.toSet(),
              importedMarkers: importedMarkers,
              temporalMarkers: temporals,
            ),
          );
        }
      },
    );
  }

  Future<void> clearTemporaryMarker() async {
    state.map(
      failure: (failure) => null,
      filteredOut: (filteredOut) {
        emit(filteredOut.copyWith(temporalMarkers: {}));
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
