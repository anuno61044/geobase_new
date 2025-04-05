part of 'categorylist_bloc.dart';

@freezed
class CategoryListState with _$CategoryListState {
  const factory CategoryListState.initial() = _Initial;
  const factory CategoryListState.fetchInProgress() = _FetchInProgress;
  const factory CategoryListState.fetchSuccess({
    required List<CategoryGetEntity> categories,
  }) = _FetchSuccess;
  const factory CategoryListState.fetchSuccessNotFound() =
      _FetchSuccessNotFound;
  const factory CategoryListState.fetchFailure({
    required String error,
  }) = _FetchFailure;

  // Nuevos estados para exportación (mismo formato con _)
  const factory CategoryListState.exportInProgress() = 
      _ExportInProgress;
  const factory CategoryListState.exportSuccess({
    required String filePath,  // Ruta del archivo guardado
  }) = _ExportSuccess;
  const factory CategoryListState.exportFailure({
    required String error,
  }) = _ExportFailure;
}
