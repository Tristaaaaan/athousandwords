// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportData _$ReportDataFromJson(Map<String, dynamic> json) {
  return _ReportData.fromJson(json);
}

/// @nodoc
mixin _$ReportData {
  String? get reportId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get storyId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get reportedAt => throw _privateConstructorUsedError;

  /// Serializes this ReportData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportDataCopyWith<ReportData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportDataCopyWith<$Res> {
  factory $ReportDataCopyWith(
          ReportData value, $Res Function(ReportData) then) =
      _$ReportDataCopyWithImpl<$Res, ReportData>;
  @useResult
  $Res call(
      {String? reportId,
      String userId,
      String storyId,
      @TimestampConverter() Timestamp reportedAt});
}

/// @nodoc
class _$ReportDataCopyWithImpl<$Res, $Val extends ReportData>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = freezed,
    Object? userId = null,
    Object? storyId = null,
    Object? reportedAt = null,
  }) {
    return _then(_value.copyWith(
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportDataImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$ReportDataImplCopyWith(
          _$ReportDataImpl value, $Res Function(_$ReportDataImpl) then) =
      __$$ReportDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? reportId,
      String userId,
      String storyId,
      @TimestampConverter() Timestamp reportedAt});
}

/// @nodoc
class __$$ReportDataImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$ReportDataImpl>
    implements _$$ReportDataImplCopyWith<$Res> {
  __$$ReportDataImplCopyWithImpl(
      _$ReportDataImpl _value, $Res Function(_$ReportDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = freezed,
    Object? userId = null,
    Object? storyId = null,
    Object? reportedAt = null,
  }) {
    return _then(_$ReportDataImpl(
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportDataImpl extends _ReportData {
  const _$ReportDataImpl(
      {this.reportId,
      required this.userId,
      required this.storyId,
      @TimestampConverter() required this.reportedAt})
      : super._();

  factory _$ReportDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportDataImplFromJson(json);

  @override
  final String? reportId;
  @override
  final String userId;
  @override
  final String storyId;
  @override
  @TimestampConverter()
  final Timestamp reportedAt;

  @override
  String toString() {
    return 'ReportData(reportId: $reportId, userId: $userId, storyId: $storyId, reportedAt: $reportedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportDataImpl &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reportId, userId, storyId, reportedAt);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      __$$ReportDataImplCopyWithImpl<_$ReportDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportDataImplToJson(
      this,
    );
  }
}

abstract class _ReportData extends ReportData {
  const factory _ReportData(
          {final String? reportId,
          required final String userId,
          required final String storyId,
          @TimestampConverter() required final Timestamp reportedAt}) =
      _$ReportDataImpl;
  const _ReportData._() : super._();

  factory _ReportData.fromJson(Map<String, dynamic> json) =
      _$ReportDataImpl.fromJson;

  @override
  String? get reportId;
  @override
  String get userId;
  @override
  String get storyId;
  @override
  @TimestampConverter()
  Timestamp get reportedAt;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
