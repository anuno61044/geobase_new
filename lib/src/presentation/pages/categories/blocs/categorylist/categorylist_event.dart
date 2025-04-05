part of 'categorylist_bloc.dart';

@freezed
class CategoryListEvent with _$CategoryListEvent {
  const factory CategoryListEvent.fetched({
    required String query,
  }) = _Fetched;
  // Nuevo evento para exportar a JSON
  const factory CategoryListEvent.exportToJson() = _ExportToJson;
}
