import 'package:athousandwords/core/appmodels/story.dart';

abstract class StoryRepository {
  Future<void> createStory(StoryData storyData);
  Stream<StoryData> getStoryStream();
  Future<void> addBookmark(String storyId, String userId);
  Future<void> removeBookmark(String storyId, String userId);
}
