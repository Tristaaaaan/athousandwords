// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final storyContentControllerProvider =
//     StateNotifierProvider.family<ReviewContentController, ReviewState, String>(
//       (ref, studioId) => ReviewContentController(
//         ref.watch(reviewRepositoryProvider),
//         ref.watch(userRepositoryProvider), // Add user repo
//         studioId,
//       ),
//     );

// class ReviewContentController extends StateNotifier<ReviewState> {
//   final ReviewRepository _reviewContentRepository;
//   final UserRepository userRepository;
//   final String studioId;

//   ReviewContentController(
//     this._reviewContentRepository,
//     this.userRepository,
//     this.studioId,
//   ) : super(const ReviewState.initial()) {
//     reviewContentData();
//   }

//   Future<void> reviewContentData() async {
//     state = const ReviewState.loading();

//     try {
//       final reviewsData = await _reviewContentRepository.getReviews(studioId);

//       if (reviewsData.reviews.isEmpty) {
//         state = const ReviewState.empty();
//         return;
//       }

//       state = ReviewState.loaded(
//         review: reviewsData.reviews,
//         users: reviewsData.users,
//       );
//     } catch (e) {
//       state = ReviewState.error(e.toString());
//     }
//   }

//   Future<void> refreshDashboard() async {
//     await reviewContentData();
//   }
// }
