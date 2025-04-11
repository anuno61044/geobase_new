// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'categories_exporter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategoriesExporterState {
  CategoryExporterStatus get status => throw _privateConstructorUsedError;
  List<CategoryGetEntity> get categories => throw _privateConstructorUsedError;
  String? get filePath => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)
        state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)?
        state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)?
        state,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_State value) state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_State value)? state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_State value)? state,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesExporterStateCopyWith<CategoriesExporterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesExporterStateCopyWith<$Res> {
  factory $CategoriesExporterStateCopyWith(CategoriesExporterState value,
          $Res Function(CategoriesExporterState) then) =
      _$CategoriesExporterStateCopyWithImpl<$Res, CategoriesExporterState>;
  @useResult
  $Res call(
      {CategoryExporterStatus status,
      List<CategoryGetEntity> categories,
      String? filePath,
      String? message});
}

/// @nodoc
class _$CategoriesExporterStateCopyWithImpl<$Res,
        $Val extends CategoriesExporterState>
    implements $CategoriesExporterStateCopyWith<$Res> {
  _$CategoriesExporterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? categories = null,
    Object? filePath = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryExporterStatus,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryGetEntity>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StateCopyWith<$Res>
    implements $CategoriesExporterStateCopyWith<$Res> {
  factory _$$_StateCopyWith(_$_State value, $Res Function(_$_State) then) =
      __$$_StateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CategoryExporterStatus status,
      List<CategoryGetEntity> categories,
      String? filePath,
      String? message});
}

/// @nodoc
class __$$_StateCopyWithImpl<$Res>
    extends _$CategoriesExporterStateCopyWithImpl<$Res, _$_State>
    implements _$$_StateCopyWith<$Res> {
  __$$_StateCopyWithImpl(_$_State _value, $Res Function(_$_State) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? categories = null,
    Object? filePath = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_State(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryExporterStatus,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryGetEntity>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_State implements _State {
  const _$_State(
      {this.status = CategoryExporterStatus.NotLoaded,
      final List<CategoryGetEntity> categories = const <CategoryGetEntity>[],
      this.filePath,
      this.message})
      : _categories = categories;

  @override
  @JsonKey()
  final CategoryExporterStatus status;
  final List<CategoryGetEntity> _categories;
  @override
  @JsonKey()
  List<CategoryGetEntity> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? filePath;
  @override
  final String? message;

  @override
  String toString() {
    return 'CategoriesExporterState.state(status: $status, categories: $categories, filePath: $filePath, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_State &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_categories), filePath, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StateCopyWith<_$_State> get copyWith =>
      __$$_StateCopyWithImpl<_$_State>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)
        state,
  }) {
    return state(status, categories, filePath, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)?
        state,
  }) {
    return state?.call(status, categories, filePath, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            CategoryExporterStatus status,
            List<CategoryGetEntity> categories,
            String? filePath,
            String? message)?
        state,
    required TResult orElse(),
  }) {
    if (state != null) {
      return state(status, categories, filePath, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_State value) state,
  }) {
    return state(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_State value)? state,
  }) {
    return state?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_State value)? state,
    required TResult orElse(),
  }) {
    if (state != null) {
      return state(this);
    }
    return orElse();
  }
}

abstract class _State implements CategoriesExporterState {
  const factory _State(
      {final CategoryExporterStatus status,
      final List<CategoryGetEntity> categories,
      final String? filePath,
      final String? message}) = _$_State;

  @override
  CategoryExporterStatus get status;
  @override
  List<CategoryGetEntity> get categories;
  @override
  String? get filePath;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_StateCopyWith<_$_State> get copyWith =>
      throw _privateConstructorUsedError;
}
