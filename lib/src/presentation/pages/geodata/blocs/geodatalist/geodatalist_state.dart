part of 'geodatalist_bloc.dart';

@freezed
class GeodataListState with _$GeodataListState {
  const factory GeodataListState.initial() = _Initial;
  const factory GeodataListState.fetchInProgress() = _FetchInProgress;
  const factory GeodataListState.fetchSuccess({
    required List<GeodataGetEntity> geodataList,
  }) = _FetchSuccess;
  const factory GeodataListState.fetchSuccessNotFound() = _FetchSuccessNotFound;
  const factory GeodataListState.fetchFailure({
    required String error,
  }) = _FetchFailure;

  // Nuevos estados para exportación
  const factory GeodataListState.exportInProgress() = _ExportInProgress;
  const factory GeodataListState.exportSuccess({
    required String filePath,
  }) = _ExportSuccess;
  const factory GeodataListState.exportFailure({
    required String error,
  }) = _ExportFailure;
}
