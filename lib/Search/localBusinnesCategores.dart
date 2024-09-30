import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:abrin_app_new/Search/business_detail.dart';
import 'package:abrin_app_new/Search/localBusinesscategory.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';


class Localbusinnescategores extends StatefulWidget {
  final Business businescategory;
  // final LatLng latLng;

  const Localbusinnescategores({
    required this.businescategory,
    // required this.latLng,
  });

  @override
  State<Localbusinnescategores> createState() => _LocalbusinnescategoresState();
}

class _LocalbusinnescategoresState extends State<Localbusinnescategores> {
  @override
  Widget build(BuildContext context) {
    final bussinusdetail = widget.businescategory;
    return ListTile(
      leading: Container(
        height: 100,
        child: Image.network(
          widget.businescategory.profilePicture,
          width: 80,
          height: 100,
          fit:BoxFit.cover,
        ),
      ),
      title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(widget.businescategory.name)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.businescategory.category),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(widget.businescategory.location)),
          // Row(
          //   children: [
          //     RatingBar(
          //       size: 16,
          //       filledIcon: Icons.star,
          //       filledColor: Color.fromARGB(255, 243, 180, 33),
          //       emptyColor: const Color.fromARGB(255, 222, 219, 219),
          //       emptyIcon: Icons.star,
          //       onRatingChanged: (value) => debugPrint('$value'),
          //       initialRating: businescategory.rating,
          //       maxRating: 5,
          //     ),
          //   ],
          // ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewsScreen(
                customRating: CustomRating(
                    coverPicture: bussinusdetail.coverPicture,
                    type: bussinusdetail.category,
                    name: bussinusdetail.name,
                    address: bussinusdetail.location,
                    description: bussinusdetail.description,
                    profilePicture: bussinusdetail.profilePicture,
                    isVerified: bussinusdetail.isVerified,
                    phone: bussinusdetail.phone,
                    website: bussinusdetail.website,
                    socialMedia: bussinusdetail.socialMedia,
                    id: bussinusdetail.socialMedia, email: bussinusdetail.email, city: '${bussinusdetail.city}',),
                bottomModel: BottomModel(
                    title: bussinusdetail.name,
                    image: bussinusdetail.coverPicture,
                    message: bussinusdetail.category,
                    time: bussinusdetail.name),
                businessId: bussinusdetail.id),
          ),
        );
      },
    );
  }
}
