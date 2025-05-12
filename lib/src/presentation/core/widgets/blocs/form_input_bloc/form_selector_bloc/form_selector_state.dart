part of './form_selector_cubit.dart';

@freezed
class FormSelectorState with _$FormSelectorState {
  const factory FormSelectorState.initial() = _Initial;
  const factory FormSelectorState.loading() = _Loading;
  const factory FormSelectorState.loaded(FieldTypeFormGetEntity form) = _Loaded;
  const factory FormSelectorState.empty() = _Empty;
  const factory FormSelectorState.error(String message) = _Error;
}