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
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: state.homeScrollController,
                itemCount:
                    state.bookmarkWithStories.length +
                    (state.hasNextStories ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.bookmarkWithStories.length) {
                    final bws = state.bookmarkWithStories[index];
                    final bookmark = bws.bookmark;
                    final story = bws.story;

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
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Story Title: ${story.title}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bookmarked At: ${bookmark.bookmarkedAt}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
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
