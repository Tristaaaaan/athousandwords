import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? reviewId;
  final String userId;
  final String studioId;
  final int experienceRating;
  final int instrumentRating;
  final bool? wouldRecommend;
  final String writtenReview;
  final Timestamp createdAt;
  final Timestamp? updatedAt;
  final List<String?>? images; // nullable list with 3 nullable strings

  ReviewModel({
    this.reviewId,
    required this.userId,
    required this.studioId,
    required this.experienceRating,
    required this.instrumentRating,
    required this.wouldRecommend,
    required this.writtenReview,
    required this.createdAt,
    this.updatedAt,
    this.images,
  }) : assert(images == null || images.length == 3,
            'If provided, images must contain exactly 3 items');

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId'] as String?,
      userId: map['userId'] as String,
      studioId: map['studioId'] as String,
      experienceRating: map['experienceRating'] as int,
      instrumentRating: map['instrumentRating'] as int,
      wouldRecommend: map['wouldRecommend'] as bool?,
      writtenReview: map['writtenReview'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp?,
      images: map['images'] != null
          ? List<String?>.from(map['images'] as List)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'userId': userId,
      'studioId': studioId,
      'experienceRating': experienceRating,
      'instrumentRating': instrumentRating,
      'wouldRecommend': wouldRecommend,
      'writtenReview': writtenReview,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'images': images,
    };
  }

  factory ReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ReviewModel(
      reviewId: doc.id,
      userId: data['userId'] as String,
      studioId: data['studioId'] as String,
      experienceRating: data['experienceRating'] as int,
      instrumentRating: data['instrumentRating'] as int,
      wouldRecommend: data['wouldRecommend'] as bool?, // ✅ updated
      writtenReview: data['writtenReview'] as String,
      createdAt: data['createdAt'] as Timestamp,
      updatedAt: data['updatedAt'] as Timestamp?,
      images: data['images'] != null
          ? List<String?>.from(data['images'] as List)
          : null,
    );
  }
}
