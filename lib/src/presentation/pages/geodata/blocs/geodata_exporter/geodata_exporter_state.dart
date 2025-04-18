part of 'geodata_exporter_cubit.dart';

@freezed
class GeodataExporterState with _$GeodataExporterState {
  const factory GeodataExporterState.state({
    @Default(GeodataExporterStatus.NotLoaded) GeodataExporterStatus status,
    @Default(<GeodataGetEntity>[]) List<GeodataGetEntity> geodatas,
    String? filePath,
    String? message,
  }) = _State;
}

enum GeodataExporterStatus {
  NotLoaded,
  FetchInProgress(isLoading: true),
  FetchSuccessNotFound(isLoaded: true),
  FetchSuccess(isLoaded: true),
  FetchFailure(isFailure: true),
  ExportInProgress(isLoading: true),
  ExportFailure(isFailure: true),
  ExportSuccess(isLoaded: true);

  const GeodataExporterStatus({
    this.isLoaded = false,
    this.isFailure = false,
    this.isLoading = false,
  });

  final bool isLoading;
  final bool isLoaded;
  final bool isFailure;
}