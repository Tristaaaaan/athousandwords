import 'package:athousandwords/features/story/domain/story_repo.dart';
import 'package:athousandwords/features/story/presentation/provider/story_state.dart';
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

      state = StoryState.loaded(story: storyData);
    } catch (e) {
      state = StoryState.error(e.toString());
    }
  }

  Future<void> refreshStory() async {
    await getStory();
  }
}
