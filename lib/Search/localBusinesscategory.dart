import 'package:flutter/material.dart';


class LocalBusinessCategory {
  final String businessName;
  final String imagePath;
  final String category;
  final String location;
  // final LatLng latLng;
  final double rating;


  LocalBusinessCategory({
    required this.businessName,
    required this.imagePath,
    required this.category,
    required this.location,
    // required this.latLng,
    required this.rating,
  });
}

class bussinessModel{
   final String coverPicture;
  final String type;
  final String name;
  final String address;
  final String description;
  final double rating;
  final bool isVerified;
  final String profilePicture;
  final List<String>? galleryImages; 
  final String phone;
   final String? email;
    
   final String website;
  final  String socialMedia;
   final String id;
   bussinessModel({
   
    required this.coverPicture,
    required this.type,
    required this.name,
    required this.address,
    required this.rating,
    required this.description,
    required this.profilePicture,
    required this.isVerified,
     this.galleryImages, 
     required this.phone,
     required this.website,
     required this.socialMedia,
     required this.email,
      required this.id// Optional parameter
  }) ;

}
