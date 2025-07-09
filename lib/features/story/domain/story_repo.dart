import 'package:athousandwords/core/appmodels/story.dart';

abstract class StoryRepository {
  Future<void> createStory(StoryData storyData);
  Future<StoryData> getStory();
  Future<void> addBookmark(String storyId, String userId);
  Future<void> removeBookmark(String storyId, String userId);
  Future<bool> isBookmarked(String storyId, String userId);
}

class StoryInfo {
  final StoryData story;
  final bool isBookmarked;

  StoryInfo({required this.story, required this.isBookmarked});
}
