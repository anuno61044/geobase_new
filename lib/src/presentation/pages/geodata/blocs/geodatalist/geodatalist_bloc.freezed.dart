// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'geodatalist_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GeodataListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? categoryId) fetched,
    required TResult Function() exportData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? categoryId)? fetched,
    TResult? Function()? exportData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? categoryId)? fetched,
    TResult Function()? exportData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Fetched value) fetched,
    required TResult Function(_ExportData value) exportData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Fetched value)? fetched,
    TResult? Function(_ExportData value)? exportData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Fetched value)? fetched,
    TResult Function(_ExportData value)? exportData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeodataListEventCopyWith<$Res> {
  factory $GeodataListEventCopyWith(
          GeodataListEvent value, $Res Function(GeodataListEvent) then) =
      _$GeodataListEventCopyWithImpl<$Res, GeodataListEvent>;
}

/// @nodoc
class _$GeodataListEventCopyWithImpl<$Res, $Val extends GeodataListEvent>
    implements $GeodataListEventCopyWith<$Res> {
  _$GeodataListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_FetchedCopyWith<$Res> {
  factory _$$_FetchedCopyWith(
          _$_Fetched value, $Res Function(_$_Fetched) then) =
      __$$_FetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({int? categoryId});
}

/// @nodoc
class __$$_FetchedCopyWithImpl<$Res>
    extends _$GeodataListEventCopyWithImpl<$Res, _$_Fetched>
    implements _$$_FetchedCopyWith<$Res> {
  __$$_FetchedCopyWithImpl(_$_Fetched _value, $Res Function(_$_Fetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
  }) {
    return _then(_$_Fetched(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_Fetched implements _Fetched {
  const _$_Fetched({this.categoryId});

  @override
  final int? categoryId;

  @override
  String toString() {
    return 'GeodataListEvent.fetched(categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Fetched &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FetchedCopyWith<_$_Fetched> get copyWith =>
      __$$_FetchedCopyWithImpl<_$_Fetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? categoryId) fetched,
    required TResult Function() exportData,
  }) {
    return fetched(categoryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? categoryId)? fetched,
    TResult? Function()? exportData,
  }) {
    return fetched?.call(categoryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? categoryId)? fetched,
    TResult Function()? exportData,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(categoryId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Fetched value) fetched,
    required TResult Function(_ExportData value) exportData,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Fetched value)? fetched,
    TResult? Function(_ExportData value)? exportData,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Fetched value)? fetched,
    TResult Function(_ExportData value)? exportData,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class _Fetched implements GeodataListEvent {
  const factory _Fetched({final int? categoryId}) = _$_Fetched;

  int? get categoryId;
  @JsonKey(ignore: true)
  _$$_FetchedCopyWith<_$_Fetched> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ExportDataCopyWith<$Res> {
  factory _$$_ExportDataCopyWith(
          _$_ExportData value, $Res Function(_$_ExportData) then) =
      __$$_ExportDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ExportDataCopyWithImpl<$Res>
    extends _$GeodataListEventCopyWithImpl<$Res, _$_ExportData>
    implements _$$_ExportDataCopyWith<$Res> {
  __$$_ExportDataCopyWithImpl(
      _$_ExportData _value, $Res Function(_$_ExportData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_ExportData implements _ExportData {
  const _$_ExportData();

  @override
  String toString() {
    return 'GeodataListEvent.exportData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ExportData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? categoryId) fetched,
    required TResult Function() exportData,
  }) {
    return exportData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? categoryId)? fetched,
    TResult? Function()? exportData,
  }) {
    return exportData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? categoryId)? fetched,
    TResult Function()? exportData,
    required TResult orElse(),
  }) {
    if (exportData != null) {
      return exportData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Fetched value) fetched,
    required TResult Function(_ExportData value) exportData,
  }) {
    return exportData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Fetched value)? fetched,
    TResult? Function(_ExportData value)? exportData,
  }) {
    return exportData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Fetched value)? fetched,
    TResult Function(_ExportData value)? exportData,
    required TResult orElse(),
  }) {
    if (exportData != null) {
      return exportData(this);
    }
    return orElse();
  }
}

abstract class _ExportData implements GeodataListEvent {
  const factory _ExportData() = _$_ExportData;
}

/// @nodoc
mixin _$GeodataListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeodataListStateCopyWith<$Res> {
  factory $GeodataListStateCopyWith(
          GeodataListState value, $Res Function(GeodataListState) then) =
      _$GeodataListStateCopyWithImpl<$Res, GeodataListState>;
}

/// @nodoc
class _$GeodataListStateCopyWithImpl<$Res, $Val extends GeodataListState>
    implements $GeodataListStateCopyWith<$Res> {
  _$GeodataListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'GeodataListState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GeodataListState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_FetchInProgressCopyWith<$Res> {
  factory _$$_FetchInProgressCopyWith(
          _$_FetchInProgress value, $Res Function(_$_FetchInProgress) then) =
      __$$_FetchInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FetchInProgressCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_FetchInProgress>
    implements _$$_FetchInProgressCopyWith<$Res> {
  __$$_FetchInProgressCopyWithImpl(
      _$_FetchInProgress _value, $Res Function(_$_FetchInProgress) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_FetchInProgress implements _FetchInProgress {
  const _$_FetchInProgress();

  @override
  String toString() {
    return 'GeodataListState.fetchInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FetchInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return fetchInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return fetchInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchInProgress != null) {
      return fetchInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return fetchInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return fetchInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchInProgress != null) {
      return fetchInProgress(this);
    }
    return orElse();
  }
}

abstract class _FetchInProgress implements GeodataListState {
  const factory _FetchInProgress() = _$_FetchInProgress;
}

/// @nodoc
abstract class _$$_FetchSuccessCopyWith<$Res> {
  factory _$$_FetchSuccessCopyWith(
          _$_FetchSuccess value, $Res Function(_$_FetchSuccess) then) =
      __$$_FetchSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GeodataGetEntity> geodataList});
}

/// @nodoc
class __$$_FetchSuccessCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_FetchSuccess>
    implements _$$_FetchSuccessCopyWith<$Res> {
  __$$_FetchSuccessCopyWithImpl(
      _$_FetchSuccess _value, $Res Function(_$_FetchSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geodataList = null,
  }) {
    return _then(_$_FetchSuccess(
      geodataList: null == geodataList
          ? _value._geodataList
          : geodataList // ignore: cast_nullable_to_non_nullable
              as List<GeodataGetEntity>,
    ));
  }
}

/// @nodoc

class _$_FetchSuccess implements _FetchSuccess {
  const _$_FetchSuccess({required final List<GeodataGetEntity> geodataList})
      : _geodataList = geodataList;

  final List<GeodataGetEntity> _geodataList;
  @override
  List<GeodataGetEntity> get geodataList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geodataList);
  }

  @override
  String toString() {
    return 'GeodataListState.fetchSuccess(geodataList: $geodataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FetchSuccess &&
            const DeepCollectionEquality()
                .equals(other._geodataList, _geodataList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_geodataList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FetchSuccessCopyWith<_$_FetchSuccess> get copyWith =>
      __$$_FetchSuccessCopyWithImpl<_$_FetchSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return fetchSuccess(geodataList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return fetchSuccess?.call(geodataList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchSuccess != null) {
      return fetchSuccess(geodataList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return fetchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return fetchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchSuccess != null) {
      return fetchSuccess(this);
    }
    return orElse();
  }
}

abstract class _FetchSuccess implements GeodataListState {
  const factory _FetchSuccess(
      {required final List<GeodataGetEntity> geodataList}) = _$_FetchSuccess;

  List<GeodataGetEntity> get geodataList;
  @JsonKey(ignore: true)
  _$$_FetchSuccessCopyWith<_$_FetchSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FetchSuccessNotFoundCopyWith<$Res> {
  factory _$$_FetchSuccessNotFoundCopyWith(_$_FetchSuccessNotFound value,
          $Res Function(_$_FetchSuccessNotFound) then) =
      __$$_FetchSuccessNotFoundCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FetchSuccessNotFoundCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_FetchSuccessNotFound>
    implements _$$_FetchSuccessNotFoundCopyWith<$Res> {
  __$$_FetchSuccessNotFoundCopyWithImpl(_$_FetchSuccessNotFound _value,
      $Res Function(_$_FetchSuccessNotFound) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_FetchSuccessNotFound implements _FetchSuccessNotFound {
  const _$_FetchSuccessNotFound();

  @override
  String toString() {
    return 'GeodataListState.fetchSuccessNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FetchSuccessNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return fetchSuccessNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return fetchSuccessNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchSuccessNotFound != null) {
      return fetchSuccessNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return fetchSuccessNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return fetchSuccessNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchSuccessNotFound != null) {
      return fetchSuccessNotFound(this);
    }
    return orElse();
  }
}

abstract class _FetchSuccessNotFound implements GeodataListState {
  const factory _FetchSuccessNotFound() = _$_FetchSuccessNotFound;
}

/// @nodoc
abstract class _$$_FetchFailureCopyWith<$Res> {
  factory _$$_FetchFailureCopyWith(
          _$_FetchFailure value, $Res Function(_$_FetchFailure) then) =
      __$$_FetchFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$_FetchFailureCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_FetchFailure>
    implements _$$_FetchFailureCopyWith<$Res> {
  __$$_FetchFailureCopyWithImpl(
      _$_FetchFailure _value, $Res Function(_$_FetchFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$_FetchFailure(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FetchFailure implements _FetchFailure {
  const _$_FetchFailure({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'GeodataListState.fetchFailure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FetchFailure &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FetchFailureCopyWith<_$_FetchFailure> get copyWith =>
      __$$_FetchFailureCopyWithImpl<_$_FetchFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return fetchFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return fetchFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchFailure != null) {
      return fetchFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return fetchFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return fetchFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (fetchFailure != null) {
      return fetchFailure(this);
    }
    return orElse();
  }
}

abstract class _FetchFailure implements GeodataListState {
  const factory _FetchFailure({required final String error}) = _$_FetchFailure;

  String get error;
  @JsonKey(ignore: true)
  _$$_FetchFailureCopyWith<_$_FetchFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ExportInProgressCopyWith<$Res> {
  factory _$$_ExportInProgressCopyWith(
          _$_ExportInProgress value, $Res Function(_$_ExportInProgress) then) =
      __$$_ExportInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ExportInProgressCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_ExportInProgress>
    implements _$$_ExportInProgressCopyWith<$Res> {
  __$$_ExportInProgressCopyWithImpl(
      _$_ExportInProgress _value, $Res Function(_$_ExportInProgress) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_ExportInProgress implements _ExportInProgress {
  const _$_ExportInProgress();

  @override
  String toString() {
    return 'GeodataListState.exportInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ExportInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return exportInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return exportInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportInProgress != null) {
      return exportInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return exportInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return exportInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportInProgress != null) {
      return exportInProgress(this);
    }
    return orElse();
  }
}

abstract class _ExportInProgress implements GeodataListState {
  const factory _ExportInProgress() = _$_ExportInProgress;
}

/// @nodoc
abstract class _$$_ExportSuccessCopyWith<$Res> {
  factory _$$_ExportSuccessCopyWith(
          _$_ExportSuccess value, $Res Function(_$_ExportSuccess) then) =
      __$$_ExportSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({String filePath});
}

/// @nodoc
class __$$_ExportSuccessCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_ExportSuccess>
    implements _$$_ExportSuccessCopyWith<$Res> {
  __$$_ExportSuccessCopyWithImpl(
      _$_ExportSuccess _value, $Res Function(_$_ExportSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
  }) {
    return _then(_$_ExportSuccess(
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ExportSuccess implements _ExportSuccess {
  const _$_ExportSuccess({required this.filePath});

  @override
  final String filePath;

  @override
  String toString() {
    return 'GeodataListState.exportSuccess(filePath: $filePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExportSuccess &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExportSuccessCopyWith<_$_ExportSuccess> get copyWith =>
      __$$_ExportSuccessCopyWithImpl<_$_ExportSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return exportSuccess(filePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return exportSuccess?.call(filePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportSuccess != null) {
      return exportSuccess(filePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return exportSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return exportSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportSuccess != null) {
      return exportSuccess(this);
    }
    return orElse();
  }
}

abstract class _ExportSuccess implements GeodataListState {
  const factory _ExportSuccess({required final String filePath}) =
      _$_ExportSuccess;

  String get filePath;
  @JsonKey(ignore: true)
  _$$_ExportSuccessCopyWith<_$_ExportSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ExportFailureCopyWith<$Res> {
  factory _$$_ExportFailureCopyWith(
          _$_ExportFailure value, $Res Function(_$_ExportFailure) then) =
      __$$_ExportFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$_ExportFailureCopyWithImpl<$Res>
    extends _$GeodataListStateCopyWithImpl<$Res, _$_ExportFailure>
    implements _$$_ExportFailureCopyWith<$Res> {
  __$$_ExportFailureCopyWithImpl(
      _$_ExportFailure _value, $Res Function(_$_ExportFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$_ExportFailure(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ExportFailure implements _ExportFailure {
  const _$_ExportFailure({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'GeodataListState.exportFailure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExportFailure &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExportFailureCopyWith<_$_ExportFailure> get copyWith =>
      __$$_ExportFailureCopyWithImpl<_$_ExportFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchInProgress,
    required TResult Function(List<GeodataGetEntity> geodataList) fetchSuccess,
    required TResult Function() fetchSuccessNotFound,
    required TResult Function(String error) fetchFailure,
    required TResult Function() exportInProgress,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function(String error) exportFailure,
  }) {
    return exportFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchInProgress,
    TResult? Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult? Function()? fetchSuccessNotFound,
    TResult? Function(String error)? fetchFailure,
    TResult? Function()? exportInProgress,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function(String error)? exportFailure,
  }) {
    return exportFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchInProgress,
    TResult Function(List<GeodataGetEntity> geodataList)? fetchSuccess,
    TResult Function()? fetchSuccessNotFound,
    TResult Function(String error)? fetchFailure,
    TResult Function()? exportInProgress,
    TResult Function(String filePath)? exportSuccess,
    TResult Function(String error)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportFailure != null) {
      return exportFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchInProgress value) fetchInProgress,
    required TResult Function(_FetchSuccess value) fetchSuccess,
    required TResult Function(_FetchSuccessNotFound value) fetchSuccessNotFound,
    required TResult Function(_FetchFailure value) fetchFailure,
    required TResult Function(_ExportInProgress value) exportInProgress,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_ExportFailure value) exportFailure,
  }) {
    return exportFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchInProgress value)? fetchInProgress,
    TResult? Function(_FetchSuccess value)? fetchSuccess,
    TResult? Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult? Function(_FetchFailure value)? fetchFailure,
    TResult? Function(_ExportInProgress value)? exportInProgress,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_ExportFailure value)? exportFailure,
  }) {
    return exportFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchInProgress value)? fetchInProgress,
    TResult Function(_FetchSuccess value)? fetchSuccess,
    TResult Function(_FetchSuccessNotFound value)? fetchSuccessNotFound,
    TResult Function(_FetchFailure value)? fetchFailure,
    TResult Function(_ExportInProgress value)? exportInProgress,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_ExportFailure value)? exportFailure,
    required TResult orElse(),
  }) {
    if (exportFailure != null) {
      return exportFailure(this);
    }
    return orElse();
  }
}

abstract class _ExportFailure implements GeodataListState {
  const factory _ExportFailure({required final String error}) =
      _$_ExportFailure;

  String get error;
  @JsonKey(ignore: true)
  _$$_ExportFailureCopyWith<_$_ExportFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
