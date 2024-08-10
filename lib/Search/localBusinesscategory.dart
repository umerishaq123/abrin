import 'package:google_maps_flutter/google_maps_flutter.dart';

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
