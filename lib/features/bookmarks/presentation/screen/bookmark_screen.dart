import 'package:athousandwords/features/bookmarks/presentation/providers/story_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final state = ref.watch(realtimeBookmarkStoryStateProvider(uid));

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
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bookmarked at: ${bookmark.bookmarkedAt}'),
                          Text('Story ID: ${bookmark.storyId ?? "No ID"}'),
                        ],
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
