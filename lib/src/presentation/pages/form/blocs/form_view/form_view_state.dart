part of 'form_view_cubit.dart';

@freezed
abstract class FormViewState with _$FormViewState {
  const factory FormViewState.fetchInProgress() = _FetchInProgress;
  const factory FormViewState.fetchSuccess({
    required FieldTypeFormGetEntity form,
  }) = _FetchSuccess;
  const factory FormViewState.fetchFailure({
    required String error,
  }) = _FetchFailure;
}
