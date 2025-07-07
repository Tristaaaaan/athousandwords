import 'package:athousandwords/core/appmodels/story.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState.initial() = _Initial;
  const factory StoryState.loading() = _Loading;
  const factory StoryState.loaded({StoryData? story}) = _Loaded;
  const factory StoryState.error(String message) = _Error;
  const factory StoryState.empty() = _Empty;
}
