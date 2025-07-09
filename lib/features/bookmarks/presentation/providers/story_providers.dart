import 'package:athousandwords/features/bookmarks/domain/realtime_story_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'realtime_story_states.dart';

final realtimeStoryRepositoryProvider =
    Provider.family<RealTimeStoryBookMarkRepository, String>((ref, userId) {
      return RealTimeStoryBookMarkRepository(userId: userId);
    });

final realtimeBookmarkStoryStateProvider =
    ChangeNotifierProvider.family<RealTimeBookmarkStoryState, String>((
      ref,
      userId,
    ) {
      final repo = ref.watch(realtimeStoryRepositoryProvider(userId));
      return RealTimeBookmarkStoryState(repo);
    });
