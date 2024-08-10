
import 'package:abrin_app_new/Search/localBusinesscategory.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localbusinnescategores extends StatelessWidget {
  final LocalBusinessCategory businescategory;
  final LatLng latLng;

  const Localbusinnescategores({
    required this.businescategory,
    required this.latLng,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 100,
        child: Image.network(
          businescategory.imagePath,
          width: 80,
          height: 100,
          fit: BoxFit.fill,
        ),
      ),
      title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(businescategory.businessName)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(businescategory.category),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(businescategory.location)),
          Row(
            children: [
              RatingBar(
                size: 16,
                filledIcon: Icons.star,
                filledColor: Color.fromARGB(255, 243, 180, 33),
                emptyColor: const Color.fromARGB(255, 222, 219, 219),
                emptyIcon: Icons.star,
                onRatingChanged: (value) => debugPrint('$value'),
                initialRating: businescategory.rating,
                maxRating: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
