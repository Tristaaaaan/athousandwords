import 'package:athousandwords/features/authentication/auth_services.dart';
import 'package:athousandwords/features/profile/presentation/providers/edit_user_story.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../commons/widgets/textfields/regular_textfield.dart';
import '../../../../core/appmodels/story.dart';
import '../../../story/presentation/provider/story_controller.dart';
import '../providers/profile_controller.dart';

String getHighResPhotoUrl(String? photoUrl) {
  // Replace resolution specifier (e.g., s96-c) with s512-c
  return photoUrl!.replaceFirst(RegExp(r'=s\d+-c$'), '=s512-c');
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final AuthServices authServices = AuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileControllerProvider);
    final isEdit = ref.watch(editUserStoryProvider);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ...profileData.when(
              initial: () => [const SliverToBoxAdapter(child: SizedBox())],
              loading: () => [
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (message) => [
                SliverToBoxAdapter(
                  child: Center(child: Text('Error: $message')),
                ),
              ],
              empty: () => [
                const SliverToBoxAdapter(
                  child: Center(child: Text('No profile data available')),
                ),
              ],
              loaded: (profileData) => [
                SliverAppBar(
                  expandedHeight: 400,
                  floating: false,

                  actions: [
                    InkWell(
                      onTap: () async {
                        await authServices.signOutAccount(ref);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12, top: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.surface,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        // Background image
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: CachedNetworkImage(
                            imageUrl: profileData.user.imageUrl != null
                                ? getHighResPhotoUrl(profileData.user.imageUrl!)
                                : '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Gradient overlay at the bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black54,
                                  Colors.black87,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Name text
                        Positioned(
                          bottom: 40,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              profileData.user.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Edit / Save Toggle Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tooltip(
                          message: isEdit
                              ? 'Save your story'
                              : 'Edit your story',
                          child: IconButton(
                            icon: Icon(isEdit ? Icons.check : Icons.edit),
                            onPressed: () async {
                              final isCurrentlyEditing = ref.read(
                                editUserStoryProvider,
                              );

                              if (!isCurrentlyEditing) {
                                // 🔁 ENTERING edit mode — populate fields
                                titleController.text =
                                    profileData.story?.title ?? '';
                                contentController.text =
                                    profileData.story?.content ?? '';
                              } else {
                                // ✅ LEAVING edit mode — save updated story
                                final hasChanged =
                                    titleController.text.trim() !=
                                        profileData.story?.title.trim() ||
                                    contentController.text.trim() !=
                                        profileData.story?.content.trim();

                                if (hasChanged) {
                                  await ref
                                      .read(
                                        storyContentControllerProvider.notifier,
                                      )
                                      .editStory(
                                        StoryData(
                                          title: titleController.text,
                                          content: contentController.text,
                                          userId: profileData.story!.userId,
                                          createdAt:
                                              profileData.story!.createdAt,
                                          updatedAt: Timestamp.fromDate(
                                            DateTime.now(),
                                          ),
                                          storyId: profileData.story?.storyId,
                                        ),
                                      );

                                  await ref
                                      .read(profileControllerProvider.notifier)
                                      .refreshDashboard();
                                } else {
                                  debugPrint(
                                    'No changes made — skipping update',
                                  );
                                  // Optionally show a SnackBar or Toast
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No changes to save'),
                                    ),
                                  );
                                }
                              }

                              // 🔁 Toggle edit mode
                              ref
                                  .read(editUserStoryProvider.notifier)
                                  .update((state) => !state);
                            },
                          ),
                        ),
                      ],
                    ),

                    // Title Field or Display
                    if (isEdit)
                      StoryTextField(
                        controller: titleController,
                        hintText: 'Title',
                        fontSize: 40,
                        minWords: 1,
                        maxWords: 8,
                        onChanged: (_) => setState(() {}),
                      )
                    else
                      StoryTitle(title: profileData.story?.title ?? 'No Title'),

                    const SizedBox(height: 16),
                    Divider(thickness: 1, indent: 16, endIndent: 16),
                    const SizedBox(height: 16),
                    // Content Field or Display
                    if (isEdit)
                      StoryTextField(
                        controller: contentController,
                        hintText: 'Tell your story...',
                        fontSize: 18,
                        minWords: 1000,
                        maxWords: 1500,
                        onChanged: (_) => setState(() {}),
                      )
                    else
                      StoryContent(
                        content:
                            profileData.story?.content ??
                            'Currently no story added',
                      ),

                    const SizedBox(height: 24),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
