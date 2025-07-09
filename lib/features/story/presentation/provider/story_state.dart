import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/story_repo.dart';

part 'story_state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState.initial() = _Initial;
  const factory StoryState.loading() = _Loading;
  const factory StoryState.loaded({StoryInfo? story}) = _Loaded;
  const factory StoryState.error(String message) = _Error;
  const factory StoryState.empty() = _Empty;
}
