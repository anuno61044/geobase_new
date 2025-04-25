part of 'form_list_cubit.dart';

@freezed
class FormListState with _$FormListState {
  const factory FormListState.initial() = _Initial;
  const factory FormListState.fetchInProgress() = _FetchInProgress;
  const factory FormListState.fetchSuccess({
    required List<FieldTypeFormGetEntity> forms,
  }) = _FetchSuccess;
  const factory FormListState.fetchSuccessNotFound() = _FetchSuccessNotFound;
  const factory FormListState.fetchFailure({required String error}) = _FetchFailure;
}
