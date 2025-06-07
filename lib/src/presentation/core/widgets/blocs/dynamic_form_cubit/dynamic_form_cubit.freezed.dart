// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dynamic_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DynamicFormState {
  List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> get forms =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DynamicFormStateCopyWith<DynamicFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicFormStateCopyWith<$Res> {
  factory $DynamicFormStateCopyWith(
          DynamicFormState value, $Res Function(DynamicFormState) then) =
      _$DynamicFormStateCopyWithImpl<$Res, DynamicFormState>;
  @useResult
  $Res call({List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> forms});
}

/// @nodoc
class _$DynamicFormStateCopyWithImpl<$Res, $Val extends DynamicFormState>
    implements $DynamicFormStateCopyWith<$Res> {
  _$DynamicFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forms = null,
  }) {
    return _then(_value.copyWith(
      forms: null == forms
          ? _value.forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DynamicFormStateCopyWith<$Res>
    implements $DynamicFormStateCopyWith<$Res> {
  factory _$$_DynamicFormStateCopyWith(
          _$_DynamicFormState value, $Res Function(_$_DynamicFormState) then) =
      __$$_DynamicFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> forms});
}

/// @nodoc
class __$$_DynamicFormStateCopyWithImpl<$Res>
    extends _$DynamicFormStateCopyWithImpl<$Res, _$_DynamicFormState>
    implements _$$_DynamicFormStateCopyWith<$Res> {
  __$$_DynamicFormStateCopyWithImpl(
      _$_DynamicFormState _value, $Res Function(_$_DynamicFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forms = null,
  }) {
    return _then(_$_DynamicFormState(
      forms: null == forms
          ? _value._forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>>,
    ));
  }
}

/// @nodoc

class _$_DynamicFormState implements _DynamicFormState {
  const _$_DynamicFormState(
      {required final List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>>
          forms})
      : _forms = forms;

  final List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> _forms;
  @override
  List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> get forms {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forms);
  }

  @override
  String toString() {
    return 'DynamicFormState(forms: $forms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DynamicFormState &&
            const DeepCollectionEquality().equals(other._forms, _forms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_forms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DynamicFormStateCopyWith<_$_DynamicFormState> get copyWith =>
      __$$_DynamicFormStateCopyWithImpl<_$_DynamicFormState>(this, _$identity);
}

abstract class _DynamicFormState implements DynamicFormState {
  const factory _DynamicFormState(
      {required final List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>>
          forms}) = _$_DynamicFormState;

  @override
  List<Map<ColumnGetEntity, LyInput<FieldValueEntity>>> get forms;
  @override
  @JsonKey(ignore: true)
  _$$_DynamicFormStateCopyWith<_$_DynamicFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
