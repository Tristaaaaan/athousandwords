// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookmarkData _$BookmarkDataFromJson(Map<String, dynamic> json) {
  return _BookmarkData.fromJson(json);
}

/// @nodoc
mixin _$BookmarkData {
  String get storyId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get bookmarkedAt => throw _privateConstructorUsedError;

  /// Serializes this BookmarkData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkDataCopyWith<BookmarkData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkDataCopyWith<$Res> {
  factory $BookmarkDataCopyWith(
          BookmarkData value, $Res Function(BookmarkData) then) =
      _$BookmarkDataCopyWithImpl<$Res, BookmarkData>;
  @useResult
  $Res call({String storyId, @TimestampConverter() Timestamp bookmarkedAt});
}

/// @nodoc
class _$BookmarkDataCopyWithImpl<$Res, $Val extends BookmarkData>
    implements $BookmarkDataCopyWith<$Res> {
  _$BookmarkDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? bookmarkedAt = null,
  }) {
    return _then(_value.copyWith(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkedAt: null == bookmarkedAt
          ? _value.bookmarkedAt
          : bookmarkedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkDataImplCopyWith<$Res>
    implements $BookmarkDataCopyWith<$Res> {
  factory _$$BookmarkDataImplCopyWith(
          _$BookmarkDataImpl value, $Res Function(_$BookmarkDataImpl) then) =
      __$$BookmarkDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String storyId, @TimestampConverter() Timestamp bookmarkedAt});
}

/// @nodoc
class __$$BookmarkDataImplCopyWithImpl<$Res>
    extends _$BookmarkDataCopyWithImpl<$Res, _$BookmarkDataImpl>
    implements _$$BookmarkDataImplCopyWith<$Res> {
  __$$BookmarkDataImplCopyWithImpl(
      _$BookmarkDataImpl _value, $Res Function(_$BookmarkDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookmarkData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? bookmarkedAt = null,
  }) {
    return _then(_$BookmarkDataImpl(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkedAt: null == bookmarkedAt
          ? _value.bookmarkedAt
          : bookmarkedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkDataImpl extends _BookmarkData {
  const _$BookmarkDataImpl(
      {required this.storyId, @TimestampConverter() required this.bookmarkedAt})
      : super._();

  factory _$BookmarkDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkDataImplFromJson(json);

  @override
  final String storyId;
  @override
  @TimestampConverter()
  final Timestamp bookmarkedAt;

  @override
  String toString() {
    return 'BookmarkData(storyId: $storyId, bookmarkedAt: $bookmarkedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkDataImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.bookmarkedAt, bookmarkedAt) ||
                other.bookmarkedAt == bookmarkedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storyId, bookmarkedAt);

  /// Create a copy of BookmarkData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkDataImplCopyWith<_$BookmarkDataImpl> get copyWith =>
      __$$BookmarkDataImplCopyWithImpl<_$BookmarkDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkDataImplToJson(
      this,
    );
  }
}

abstract class _BookmarkData extends BookmarkData {
  const factory _BookmarkData(
          {required final String storyId,
          @TimestampConverter() required final Timestamp bookmarkedAt}) =
      _$BookmarkDataImpl;
  const _BookmarkData._() : super._();

  factory _BookmarkData.fromJson(Map<String, dynamic> json) =
      _$BookmarkDataImpl.fromJson;

  @override
  String get storyId;
  @override
  @TimestampConverter()
  Timestamp get bookmarkedAt;

  /// Create a copy of BookmarkData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkDataImplCopyWith<_$BookmarkDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
