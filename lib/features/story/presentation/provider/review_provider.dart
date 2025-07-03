import 'package:athousandwords/features/story/data/story_impl.dart';
import 'package:athousandwords/features/story/domain/story_repo.dart';
import 'package:riverpod/riverpod.dart';

final reviewRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryImpl();
});
