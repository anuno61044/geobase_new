part of 'categories_exporter_cubit.dart';

@freezed
class CategoriesExporterState with _$CategoriesExporterState {
  const factory CategoriesExporterState.state({
    @Default(CategoryExporterStatus.NotLoaded) CategoryExporterStatus status,
    @Default(<CategoryGetEntity>[]) List<CategoryGetEntity> categories,
    String? filePath,
    String? message,
  }) = _State;
}

enum CategoryExporterStatus {
  NotLoaded,
  FetchInProgress(isLoading: true),
  FetchSuccessNotFound(isLoaded: true),
  FetchSuccess(isLoaded: true),
  FetchFailure(isFailure: true),
  ExportInProgress(isLoading: true),
  ExportFailure(isFailure: true),
  ExportSuccess(isLoaded: true);

  const CategoryExporterStatus({
    this.isLoaded = false,
    this.isFailure = false,
    this.isLoading = false,
  });

  final bool isLoading;
  final bool isLoaded;
  final bool isFailure;
}
