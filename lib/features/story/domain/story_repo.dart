import 'package:athousandwords/core/appmodels/story.dart';

abstract class StoryRepository {
  Future<void> createStory(StoryData storyData);
  Future<StoryData> getStory();
  Future<void> addBookmark(String storyId, String userId);
  Future<void> removeBookmark(String storyId, String userId);
  Future<bool> isBookmarked(String storyId, String userId);
  Future<void> addLike(String storyId, String userId);
  Future<void> removeLike(String storyId, String userId);
  Future<bool> isLiked(String storyId, String userId);
}

class StoryInfo {
  final StoryData story;
  final bool isBookmarked;
  final bool isLiked;

  StoryInfo({
    required this.story,
    required this.isBookmarked,
    required this.isLiked,
  });

  StoryInfo copyWith({StoryData? story, bool? isBookmarked, bool? isLiked}) {
    return StoryInfo(
      story: story ?? this.story,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
