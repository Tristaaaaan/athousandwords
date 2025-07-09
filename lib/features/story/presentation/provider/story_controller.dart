import 'package:athousandwords/features/story/domain/story_repo.dart';
import 'package:athousandwords/features/story/presentation/provider/story_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/story_impl.dart';

final storyContentControllerProvider =
    StateNotifierProvider<StoryController, StoryState>(
      (ref) => StoryController(ref.watch(storyRepositoryProvider)),
    );

class StoryController extends StateNotifier<StoryState> {
  final StoryRepository _storyRepository;

  StoryController(this._storyRepository) : super(const StoryState.initial()) {
    getStory();
  }

  Future<void> getStory() async {
    state = const StoryState.loading();

    try {
      final storyData = await _storyRepository.getStory();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final isBookmarked = await _storyRepository.isBookmarked(
        storyData.storyId!,
        userId,
      );

      final storyInfo = StoryInfo(story: storyData, isBookmarked: isBookmarked);

      state = StoryState.loaded(story: storyInfo);
    } catch (e) {
      state = StoryState.error(e.toString());
    }
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

  Future<void> toggleBookmark(String storyId, String userId) async {
    try {
      StoryInfo? currentInfo;

      state.maybeWhen(loaded: (info) => currentInfo = info, orElse: () {});

      if (currentInfo == null) return;

      final isBookmarked = currentInfo!.isBookmarked;
      final story = currentInfo!.story;

      // Update Firestore
      if (isBookmarked) {
        await _storyRepository.removeBookmark(storyId, userId);
      } else {
        await _storyRepository.addBookmark(storyId, userId);
      }

      final updatedBookmarkCount = isBookmarked
          ? (story.bookmarks - 1).clamp(0, double.infinity).toInt()
          : story.bookmarks + 1;

      final updatedStory = story.copyWith(bookmarks: updatedBookmarkCount);

      final updatedInfo = StoryInfo(
        story: updatedStory,
        isBookmarked: !isBookmarked,
      );

      state = StoryState.loaded(story: updatedInfo);
    } catch (e) {
      state = StoryState.error(e.toString());
    }
  }

  Future<void> refreshStory() async {
    await getStory();
  }
}
