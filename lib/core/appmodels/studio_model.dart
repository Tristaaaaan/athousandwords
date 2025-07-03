import 'package:cloud_firestore/cloud_firestore.dart';

class StudioModel {
  String id;
  String studioName;
  String description;
  String address;
  GeoPoint location;
  String imageUrl;
  List<dynamic> followers;
  // Contact contact;
  // List<String> images;
  // List<String> facilities;
  // List<Service> services;
  // List<Availability> availability;
  // List<String> rules;
  // Ratings ratings;
  // DateTime createdAt;
  // DateTime updatedAt;
  // bool isActive;

  StudioModel({
    required this.id,
    required this.studioName,
    required this.description,
    required this.address,
    required this.location,
    required this.imageUrl,
    required this.followers,
    // required this.contact,
    // required this.images,
    // required this.facilities,
    // required this.services,
    // required this.availability,
    // required this.rules,
    // required this.ratings,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.isActive,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studioName': studioName,
      'description': description,
      'address': address,
      'location': location,
      'imageUrl': imageUrl,
      'followers': followers,
      // 'contact': contact?.toMap(),
      // 'images': images,
      // 'facilities': facilities,
      // 'services': services.map((service) => service.toMap()).toList(),
      // 'availability': availability.map((avail) => avail.toMap()).toList(),
      // 'rules': rules,
      // 'ratings': ratings?.toMap(),
      // 'createdAt': createdAt?.toIso8601String(),
      // 'updatedAt': updatedAt?.toIso8601String(),
      // 'isActive': isActive,
    };
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    return StudioModel(
      id: map['id'],
      studioName: map['studioName'],
      description: map['description'],
      address: map['address'],
      location: map['location'],
      imageUrl: map['imageUrl'],
      followers: List<String>.from(map['followers'] ?? []),
      // contact: Contact.fromMap(map['contact']),
      // images: List<String>.from(map['images'] ?? []),
      // facilities: List<String>.from(map['facilities'] ?? []),
      // services: (map['services'] as List)
      //     .map((service) => Service.fromMap(service))
      //     .toList(),
      // availability: (map['availability'] as List)
      //     .map((avail) => Availability.fromMap(avail))
      //     .toList(),
      // rules: List<String>.from(map['rules'] ?? []),
      // ratings: Ratings.fromMap(map['ratings']),
      // createdAt: DateTime.parse(map['createdAt']),
      // updatedAt: DateTime.parse(map['updatedAt']),
      // isActive: map['isActive'] ?? true,
    );
  }

  factory StudioModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return StudioModel(
      id: doc['id'],
      studioName: doc['studioName'],
      description: doc['description'],
      address: doc['address'],
      location: doc['location'],
      imageUrl: doc['imageUrl'],
      followers: doc['followers'],
    );
  }
}

class Amenities {
  bool wheelchairAccessible;
  bool privateParking;
  bool nearbyTransit;

  Amenities({
    required this.wheelchairAccessible,
    required this.privateParking,
    required this.nearbyTransit,
  });
}

class Availability {
  String day;
  List<TimeSlot> timeSlots;

  Availability({
    required this.day,
    required this.timeSlots,
  });
}

class TimeSlot {
  String start;
  String end;

  TimeSlot({
    required this.start,
    required this.end,
  });
}

class Contact {
  String phone;
  String email;
  String website;
  Social social;

  Contact({
    required this.phone,
    required this.email,
    required this.website,
    required this.social,
  });
}

class Social {
  String instagram;
  String facebook;

  Social({
    required this.instagram,
    required this.facebook,
  });
}

class Ratings {
  double average;
  int reviewsCount;

  Ratings({
    required this.average,
    required this.reviewsCount,
  });
}

class Service {
  String id;
  String name;
  String description;
  int durationMinutes;
  int priceUsd;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.priceUsd,
  });
}
