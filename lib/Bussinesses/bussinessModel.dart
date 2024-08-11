// lib/models/business.dart
class Business {
  final String name;
  final String location;
  final String category;
  final String coverPicture;
  final double rating;
  final bool isApproved;
  final bool isVerified;
  final String description;
  final int id;
  final String profilePicture;
  final String phone;
    final String? email;
    final String website;
    final String socialMedia;

  Business(
      {required this.name,
      required this.location,
      required this.category,
      required this.coverPicture,
      required this.rating,
      required this.description,
      required this.isApproved,
      required this.isVerified,
      required this.profilePicture,
      required this.id,
      required this.email,
      required this.phone,
      required this.socialMedia,
      required this.website
      });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? 1,
      name: json['name'] ?? 'No Name',
      location: json['location'] ?? 'No Address',
      category: json['category'] ?? 'No Category',
      coverPicture: json['coverPicture'] ?? 'https://default-image-url.com',
      profilePicture: json['profilePicture'] ?? 'https://default-image-url.com',
      rating: (json['rating'] ?? 0.0).toDouble(),
      isApproved: json['isApproved'] ?? false,
      isVerified: json['isVerified'] ?? false,
      description: json['description'] ?? 'No description',
      phone: json["phone"]??"",
        // email: emailValues.map[json["email"]],
        email: json["email"]??'',
        website: json["website"]??"",
        socialMedia: json["socialMedia"]??'',
    );
  }

  Object? toJson() {}
}

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