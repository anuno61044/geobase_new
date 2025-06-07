// dynamic_form_cubit_state.dart

part of 'dynamic_form_cubit.dart';

@freezed
class DynamicFormState with _$DynamicFormState {
  const factory DynamicFormState({
    required List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> forms,
  }) = _DynamicFormState;
}
