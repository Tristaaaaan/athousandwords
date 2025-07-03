import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? fullName;
  final String email;
  final String? fcmtoken;
  final String? imageUrl;

  UserModel({
    this.uid,
    this.fullName,
    required this.email,
    this.fcmtoken,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'fcmToken': fcmtoken,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      fcmtoken: map['fcmToken'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      uid: doc['uid'],
      fullName: doc['fullName'],
      email: doc['email'],
      fcmtoken: doc['fcmToken'],
      imageUrl: doc['imageUrl'],
    );
  }
}
