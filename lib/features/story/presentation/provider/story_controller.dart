import 'dart:async';

import 'package:athousandwords/features/story/domain/story_repo.dart';
import 'package:athousandwords/features/story/presentation/provider/story_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/appmodels/story.dart';
import '../../data/story_impl.dart';

final storyContentControllerProvider =
    StateNotifierProvider<StoryController, StoryState>(
      (ref) => StoryController(ref.watch(storyRepositoryProvider)),
    );

class StoryController extends StateNotifier<StoryState> {
  final StoryRepository _storyRepository;
  StreamSubscription<StoryData>? _storySubscription;

  StoryController(this._storyRepository) : super(const StoryState.initial()) {
    _listenToStory(); // Stream the first story automatically
  }

  void _listenToStory() {
    state = const StoryState.loading();

    _storySubscription?.cancel();
    _storySubscription = _storyRepository.getStoryStream().listen(
      (story) {
        state = StoryState.loaded(story: story);
      },
      onError: (e) {
        state = StoryState.error(e.toString());
      },
    );
  }

  Future<void> addBookmark(String storyId, String userId) async {
    try {
      await _storyRepository.addBookmark(storyId, userId);
    } catch (e) {
      state = StoryState.error(e.toString());
    }
  }

  Future<void> removeBookmark(String storyId, String userId) async {
    try {
      await _storyRepository.removeBookmark(storyId, userId);
    } catch (e) {
      state = StoryState.error(e.toString());
    }
  }

  // Future<void> toggleBookmark(String userId) async {
  //   final currentState = state;
  //   if (currentState is! _Loaded) return;

  //   final story = currentState.story;
  //   final storyId = story.storyId;

  //   if (storyId == null) {
  //     state = const StoryState.error("Missing story ID");
  //     return;
  //   }

  //   try {
  //     if (story.bookmarksId.contains(userId)) {
  //       await _storyRepository.removeBookmark(storyId, userId);
  //     } else {
  //       await _storyRepository.addBookmark(storyId, userId);
  //     }
  //   } catch (e) {
  //     state = StoryState.error(e.toString());
  //   }
  // }

  Future<void> refreshStory() async {
    _listenToStory(); // Simply restart the stream
  }

  @override
  void dispose() {
    _storySubscription?.cancel();
    super.dispose();
  }
}
