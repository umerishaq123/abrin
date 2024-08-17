// To parse this JSON data, do
//
//     final fetchFavruitBussineses = fetchFavruitBussinesesFromJson(jsonString);

import 'dart:convert';

List<FetchFavruitBussineses> fetchFavruitBussinesesFromJson(String str) => List<FetchFavruitBussineses>.from(json.decode(str).map((x) => FetchFavruitBussineses.fromJson(x)));

String fetchFavruitBussinesesToJson(List<FetchFavruitBussineses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchFavruitBussineses {
    String id;
    String name;
    String profilePicture;
    String coverPicture;
    String category;
    String description;
    String phone;
    String website;
    String socialMedia;
    List<String> gallery;
    String location;
    String owner;
    bool isApproved;
    bool isVerified;
    bool isHighlighted;
    List<dynamic> keywords;
    List<dynamic> reviews;
    List<dynamic> pendingModifications;
    DateTime createdAt;
    DateTime updatedAt;
      String email;
       String city;

    FetchFavruitBussineses({
        required this.id,
        required this.name,
        required this.profilePicture,
        required this.coverPicture,
        required this.category,
        required this.description,
        required this.phone,
        required this.website,
        required this.socialMedia,
        required this.gallery,
        required this.location,
        required this.owner,
        required this.isApproved,
        required this.isVerified,
        required this.isHighlighted,
        required this.keywords,
        required this.reviews,
        required this.pendingModifications,
        required this.createdAt,
        required this.updatedAt,
        required this.email,
        required this.city
    });

    factory FetchFavruitBussineses.fromJson(Map<String, dynamic> json) => FetchFavruitBussineses(
        id: json["_id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        coverPicture: json["coverPicture"],
        category: json["category"],
        description: json["description"],
        phone: json["phone"],
        website: json["website"],
        socialMedia: json["socialMedia"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        location: json["location"],
        owner: json["owner"],
        isApproved: json["isApproved"],
        isVerified: json["isVerified"],
        isHighlighted: json["isHighlighted"],
        keywords: List<dynamic>.from(json["keywords"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        pendingModifications: List<dynamic>.from(json["pendingModifications"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
           email: json["email"],
           city: json["city"],
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
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "location": location,
        "owner": owner,
        "isApproved": isApproved,
        "isVerified": isVerified,
        "isHighlighted": isHighlighted,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "pendingModifications": List<dynamic>.from(pendingModifications.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
         "email": email,
         "city": city,
    };
}
