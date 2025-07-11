import 'package:athousandwords/commons/widgets/snackbar/information_snackbar.dart';
import 'package:athousandwords/features/bookmarks/presentation/providers/story_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../story/presentation/provider/story_controller.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final state = ref.watch(realtimeBookmarkStoryStateProvider(uid));
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: state.homeScrollController,
                itemCount:
                    state.bookmarks.length + (state.hasNextStories ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.bookmarks.length) {
                    final bookmark = state.bookmarks[index];
                    return InkWell(
                      onTap: () async {
                        await ref
                            .read(storyContentControllerProvider.notifier)
                            .toggleBookmark(
                              bookmark.storyId,
                              auth.currentUser!.uid,
                            );
                        if (context.mounted) {
                          informationSnackBar(
                            context,
                            Icons.info,
                            "Bookmark removed",
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bookmarked at: ${bookmark.bookmarkedAt}'),
                            Text('Story ID: ${bookmark.storyId}'),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // Loading indicator for pagination
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: state.hideFAB
          ? null
          : FloatingActionButton(
              onPressed: () {
                state.homeScrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}
