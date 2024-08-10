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
      required this.id});

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
    );
  }

  Object? toJson() {}
}
