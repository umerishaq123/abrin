// // lib/models/business.dart
// class Business {
//   final String name;
//   final String location;
//   final String category;
//   final String coverPicture;
//   final double rating;
//   final bool isApproved;
//   final bool isVerified;
//   final String description;
//   final String id;
//   final String profilePicture;
//   final String phone;
//     final String? email;
//     final String website;
//     final String socialMedia;

//   Business(
//       {required this.name,
//       required this.location,
//       required this.category,
//       required this.coverPicture,
//       required this.rating,
//       required this.description,
//       required this.isApproved,
//       required this.isVerified,
//       required this.profilePicture,
//       required this.id,
//       required this.email,
//       required this.phone,
//       required this.socialMedia,
//       required this.website
//       });

//   factory Business.fromJson(Map<String, dynamic> json) {
//     return Business(
//       id: json['id'] ??"",
//       name: json['name'] ?? 'No Name',
//       location: json['location'] ?? 'No Address',
//       category: json['category'] ?? 'No Category',
//       coverPicture: json['coverPicture'] ?? 'https://default-image-url.com',
//       profilePicture: json['profilePicture'] ?? 'https://default-image-url.com',
//       rating: (json['rating'] ?? 0.0).toDouble(),
//       isApproved: json['isApproved'] ?? false,
//       isVerified: json['isVerified'] ?? false,
//       description: json['description'] ?? 'No description',
//       phone: json["phone"]??"",
//         // email: emailValues.map[json["email"]],
//         email: json["email"]??'',
//         website: json["website"]??"",
//         socialMedia: json["socialMedia"]??'',
//     );
//   }

//   Object? toJson() {}
// }

// enum Email {
//     ABC_GMAIL_COM,
//     UPDATEDBUSINESS_EXAMPLE_COM,
//     VXVXVD
// }

// final emailValues = EnumValues({
//     "abc@gmail.com": Email.ABC_GMAIL_COM,
//     "updatedbusiness@example.com": Email.UPDATEDBUSINESS_EXAMPLE_COM,
//     "vxvxvd": Email.VXVXVD
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }



// To parse this JSON data, do
//
//     final business = businessFromJson(jsonString);

import 'dart:convert';

List<Business> businessFromJson(String str) =>
    List<Business>.from(json.decode(str).map((x) => Business.fromJson(x)));

String businessToJson(List<Business> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Business {
  String id;
  String name;
  String profilePicture;
  String coverPicture;
  String category;
  String description;
  String phone;
  String website;
  String socialMedia;
  List<String>? gallery;
  String location;
  String? owner;
  bool isApproved;
  bool isVerified;
  bool? isHighlighted;
  List<String>? keywords;
  List<dynamic>? reviews;
  List<dynamic>? pendingModifications;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
   String? email;

  Business({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.coverPicture,
    required this.category,
    required this.description,
    required this.phone,
    required this.website,
    required this.socialMedia,
    this.gallery,
    required this.location,
    this.owner,
    required this.isApproved,
    required this.isVerified,
    this.isHighlighted,
    this.keywords,
    this.reviews,
    this.pendingModifications,
    this.createdAt,
    this.updatedAt,
    this.v,this.email,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        profilePicture: json["profilePicture"] ?? '',
        coverPicture: json["coverPicture"] ?? '',
        category: json["category"] ?? '',
        description: json["description"] ?? '',
        phone: json["phone"] ?? '',
        website: json["website"] ?? '',
        socialMedia: json["socialMedia"] ?? '',
        gallery: json["gallery"] == null
            ? null
            : List<String>.from(json["gallery"].map((x) => x)),
        location: json["location"] ?? '',
        owner: json["owner"]??'',
        isApproved: json["isApproved"] ?? false,
        isVerified: json["isVerified"] ?? false,
        isHighlighted: json["isHighlighted"]??false,
        keywords: json["keywords"] == null
            ? null
            : List<String>.from(json["keywords"].map((x) => x)),
        reviews: json["reviews"] == null
            ? null
            : List<dynamic>.from(json["reviews"].map((x) => x)),
        pendingModifications: json["pendingModifications"] == null
            ? null
            : List<dynamic>.from(json["pendingModifications"].map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
         email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profilePicture": profilePicture,
        "coverPicture": coverPicture,
        "category": category,
        "description": description,
        "phone": phone,
        "website": website,
        "socialMedia": socialMedia,
        "gallery":
            gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x)),
        "location": location,
        "owner": owner,
        "isApproved": isApproved,
        "isVerified": isVerified,
        "isHighlighted": isHighlighted,
        "keywords": keywords == null
            ? null
            : List<dynamic>.from(keywords!.map((x) => x)),
        "reviews":
            reviews == null ? null : List<dynamic>.from(reviews!.map((x) => x)),
        "pendingModifications": pendingModifications == null
            ? null
            : List<dynamic>.from(pendingModifications!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
         "email": email,
      };
}