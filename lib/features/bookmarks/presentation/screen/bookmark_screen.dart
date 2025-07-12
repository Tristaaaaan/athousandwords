import 'package:athousandwords/commons/widgets/snackbar/information_snackbar.dart';
import 'package:athousandwords/features/bookmarks/presentation/providers/story_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                    state.bookmarks.length + (state.hasNextStories ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.bookmarks.length) {
                    final bookmarkWithStory = state.bookmarks[index];
                    final story = bookmarkWithStory.story;
                    final bookmark = bookmarkWithStory.bookmark;

                    return InkWell(
                      onTap: () async {
                        await ref
                            .read(storyContentControllerProvider.notifier)
                            .toggleBookmark(
                              story.storyId!,
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
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: .1),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.shade100],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: .15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.bookmark,
                                  color: Colors.deepPurple,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    story.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 10),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 150,
                                      ),
                                      child: Text(
                                        maxLines: 2,
                                        'Bookmarked ${timeago.format(bookmark.bookmarkedAt.toDate())}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.grey.shade700,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _StatIconText(
                                      icon: Icons.favorite,
                                      value: story.likes,
                                      color: Colors.redAccent,
                                      label: 'Likes',
                                    ),
                                    const SizedBox(width: 10),
                                    _StatIconText(
                                      icon: Icons.visibility,
                                      value: story.reads,
                                      color: Colors.green,
                                      label: 'Views',
                                    ),
                                  ],
                                ),
                              ],
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

class _StatIconText extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color color;

  const _StatIconText({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          '$value $label',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

final DateFormat formatter = DateFormat('EEEE, MMM d, yyyy, hh:mm a');
