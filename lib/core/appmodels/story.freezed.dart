// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryData _$StoryDataFromJson(Map<String, dynamic> json) {
  return _StoryData.fromJson(json);
}

/// @nodoc
mixin _$StoryData {
  String? get storyId =>
      throw _privateConstructorUsedError; // 🔁 Renamed from id to storyId
  int get reads => throw _privateConstructorUsedError;
  int get bookmarks => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  List<String> get readersId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get isPublish => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get updatedAt => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this StoryData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryDataCopyWith<StoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDataCopyWith<$Res> {
  factory $StoryDataCopyWith(StoryData value, $Res Function(StoryData) then) =
      _$StoryDataCopyWithImpl<$Res, StoryData>;
  @useResult
  $Res call(
      {String? storyId,
      int reads,
      int bookmarks,
      int likes,
      List<String> readersId,
      String userId,
      bool isPublish,
      bool isDeleted,
      String title,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt,
      String content,
      List<String> tags});
}

/// @nodoc
class _$StoryDataCopyWithImpl<$Res, $Val extends StoryData>
    implements $StoryDataCopyWith<$Res> {
  _$StoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = freezed,
    Object? reads = null,
    Object? bookmarks = null,
    Object? likes = null,
    Object? readersId = null,
    Object? userId = null,
    Object? isPublish = null,
    Object? isDeleted = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? content = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      reads: null == reads
          ? _value.reads
          : reads // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarks: null == bookmarks
          ? _value.bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as int,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      readersId: null == readersId
          ? _value.readersId
          : readersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isPublish: null == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryDataImplCopyWith<$Res>
    implements $StoryDataCopyWith<$Res> {
  factory _$$StoryDataImplCopyWith(
          _$StoryDataImpl value, $Res Function(_$StoryDataImpl) then) =
      __$$StoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? storyId,
      int reads,
      int bookmarks,
      int likes,
      List<String> readersId,
      String userId,
      bool isPublish,
      bool isDeleted,
      String title,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt,
      String content,
      List<String> tags});
}

/// @nodoc
class __$$StoryDataImplCopyWithImpl<$Res>
    extends _$StoryDataCopyWithImpl<$Res, _$StoryDataImpl>
    implements _$$StoryDataImplCopyWith<$Res> {
  __$$StoryDataImplCopyWithImpl(
      _$StoryDataImpl _value, $Res Function(_$StoryDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = freezed,
    Object? reads = null,
    Object? bookmarks = null,
    Object? likes = null,
    Object? readersId = null,
    Object? userId = null,
    Object? isPublish = null,
    Object? isDeleted = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? content = null,
    Object? tags = null,
  }) {
    return _then(_$StoryDataImpl(
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      reads: null == reads
          ? _value.reads
          : reads // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarks: null == bookmarks
          ? _value.bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as int,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      readersId: null == readersId
          ? _value._readersId
          : readersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isPublish: null == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDataImpl extends _StoryData {
  const _$StoryDataImpl(
      {this.storyId,
      this.reads = 0,
      this.bookmarks = 0,
      this.likes = 0,
      final List<String> readersId = const [],
      this.userId = '',
      this.isPublish = false,
      this.isDeleted = false,
      this.title = '',
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt,
      this.content = '',
      final List<String> tags = const []})
      : _readersId = readersId,
        _tags = tags,
        super._();

  factory _$StoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDataImplFromJson(json);

  @override
  final String? storyId;
// 🔁 Renamed from id to storyId
  @override
  @JsonKey()
  final int reads;
  @override
  @JsonKey()
  final int bookmarks;
  @override
  @JsonKey()
  final int likes;
  final List<String> _readersId;
  @override
  @JsonKey()
  List<String> get readersId {
    if (_readersId is EqualUnmodifiableListView) return _readersId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readersId);
  }

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final bool isPublish;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final String title;
  @override
  @TimestampConverter()
  final Timestamp createdAt;
  @override
  @TimestampConverter()
  final Timestamp updatedAt;
  @override
  @JsonKey()
  final String content;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'StoryData(storyId: $storyId, reads: $reads, bookmarks: $bookmarks, likes: $likes, readersId: $readersId, userId: $userId, isPublish: $isPublish, isDeleted: $isDeleted, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, content: $content, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDataImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.reads, reads) || other.reads == reads) &&
            (identical(other.bookmarks, bookmarks) ||
                other.bookmarks == bookmarks) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            const DeepCollectionEquality()
                .equals(other._readersId, _readersId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isPublish, isPublish) ||
                other.isPublish == isPublish) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      storyId,
      reads,
      bookmarks,
      likes,
      const DeepCollectionEquality().hash(_readersId),
      userId,
      isPublish,
      isDeleted,
      title,
      createdAt,
      updatedAt,
      content,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      __$$StoryDataImplCopyWithImpl<_$StoryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDataImplToJson(
      this,
    );
  }
}

abstract class _StoryData extends StoryData {
  const factory _StoryData(
      {final String? storyId,
      final int reads,
      final int bookmarks,
      final int likes,
      final List<String> readersId,
      final String userId,
      final bool isPublish,
      final bool isDeleted,
      final String title,
      @TimestampConverter() required final Timestamp createdAt,
      @TimestampConverter() required final Timestamp updatedAt,
      final String content,
      final List<String> tags}) = _$StoryDataImpl;
  const _StoryData._() : super._();

  factory _StoryData.fromJson(Map<String, dynamic> json) =
      _$StoryDataImpl.fromJson;

  @override
  String? get storyId; // 🔁 Renamed from id to storyId
  @override
  int get reads;
  @override
  int get bookmarks;
  @override
  int get likes;
  @override
  List<String> get readersId;
  @override
  String get userId;
  @override
  bool get isPublish;
  @override
  bool get isDeleted;
  @override
  String get title;
  @override
  @TimestampConverter()
  Timestamp get createdAt;
  @override
  @TimestampConverter()
  Timestamp get updatedAt;
  @override
  String get content;
  @override
  List<String> get tags;

  /// Create a copy of StoryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
