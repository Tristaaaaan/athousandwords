import 'package:athousandwords/core/appmodels/story.dart';

abstract class StoryRepository {
  Future<void> createStory(StoryData storyData);
  Future<StoryData> getStory();
}
