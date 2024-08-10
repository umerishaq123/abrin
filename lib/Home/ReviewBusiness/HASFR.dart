
import 'package:abrin_app_new/Home/ReviewBusiness/Reviewmodel.dart';

class Business {
  final int id;
  final String name;
  final String category;
  final String address;
  final String coverPicture;
  final String profilePicture;
  final String description;
  final String email;
  final String phone;
  final String website;
  final List<String> galleryImages;
  final double rating;
  
  final List<ReviewModel> reviews;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.coverPicture,
    required this.profilePicture,
    required this.description,
    required this.email,
    required this.phone,
    required this.website,
    required this.galleryImages,
    required this.rating,
  
    required this.reviews,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    var reviewsJson = json['reviews'] as List;
    List<ReviewModel> reviewsList = reviewsJson.map((review) => ReviewModel.fromJson(review)).toList();

    return Business(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      address: json['address'],
      coverPicture: json['coverPicture'],
      profilePicture: json['profilePicture'],
      description: json['description'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      galleryImages: List<String>.from(json['galleryImages']),
      rating: json['rating'],
    
      reviews: reviewsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'address': address,
      'coverPicture': coverPicture,
      'profilePicture': profilePicture,
      'description': description,
      'email': email,
      'phone': phone,
      'website': website,
      'galleryImages': galleryImages,
      'rating': rating,
      
      'reviews': reviews.map((review) => review??toJson()).toList(),
    };
  }
}


class BottomReview {
  final String title;
  final String image;
  final String message;
  final String time;
  final String messicon;
  final String Rating;

  BottomReview({
    required this.title,
    required this.image,
    required this.message,
    required this.time,
    required this.messicon,
    required this.Rating,
  });
}

class CustomRating2 {
  final String ratingimage;
  final String type;
  final String customername;
  final String adress;
  final double rating;
  final String description;

  const CustomRating2({
    required this.ratingimage,
    required this.type,
    required this.customername,
    required this.adress,
    required this.rating,
    required this.description,
  });
}

