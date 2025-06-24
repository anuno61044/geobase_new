part of 'imported_geodata_cubit.dart';

@freezed
class ImportedGeodataState with _$ImportedGeodataState {
  const factory ImportedGeodataState.initial() = _Initial;
  const factory ImportedGeodataState.loading() = _Loading;
  const factory ImportedGeodataState.loaded(List<ImportedGeodataPoint> importedPoints) = _Loaded;
  const factory ImportedGeodataState.error(String message) = _Error;
}