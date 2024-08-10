import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class CustomRating extends StatelessWidget {
  final String coverPicture;
  final String type;
  final String name;
  final String address;
  final String description;
  final double rating;
  final bool isVerified;
  final String profilePicture;
  final List<String>? galleryImages; // Optional list of gallery images

  const CustomRating({
    Key? key,
    required this.coverPicture,
    required this.type,
    required this.name,
    required this.address,
    required this.rating,
    required this.description,
    required this.profilePicture,
    required this.isVerified,
     this.galleryImages, // Optional parameter
  }) : super(key: key);

  get email => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.width - 190,
              width: MediaQuery.of(context).size.width - 60,
              child: Image.network(
                coverPicture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 60,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              type,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 112, 110, 110),
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (isVerified == true) // Show only if the business is verified
                  Container(
                    height: 18,
                    width: 18,
                    child: Image.asset(
                      "assets/images/check.png",
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            Text(
              address,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                RatingBar(
                  size: 22,
                  filledIcon: Icons.star,
                  filledColor: Colors.blue,
                  emptyColor: const Color.fromARGB(255, 222, 219, 219),
                  emptyIcon: Icons.star,
                  onRatingChanged: (value) => debugPrint('$value'),
                  initialRating: rating,
                  maxRating: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Display gallery images if available
            if (galleryImages != null && galleryImages!.isNotEmpty)
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Image.network(
                          galleryImages![index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: 60,
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
