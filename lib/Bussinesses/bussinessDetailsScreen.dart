// // widgets/BusinessDetail.dart
// import 'package:flutter/material.dart';

// class BusinessDetail extends StatelessWidget {
//   final Business business;

//   const BusinessDetail({Key? key, required this.business}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(business.coverPicture),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -50,
//               left: MediaQuery.of(context).size.width / 2 - 50,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 45,
//                   backgroundImage: NetworkImage(business.profilePicture),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 60),
//         Text(
//           business.name,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           business.category,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 10),
//         StarRating(
//           rating: business.rating.round(),
//           onRatingChanged: (rating) {},
//         ),
//         Text('(${business.rating})'),
//         const SizedBox(height: 20),
//         ListTile(
//           leading: Icon(Icons.location_on),
//           title: Text(business.address),
//           onTap: () {
//             // Handle navigation to map with directions
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.phone),
//           title: Text(business.phone),
//           onTap: () {
//             // Handle making a call
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.web),
//           title: Text(business.website),
//           onTap: () {
//             // Handle opening website
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.email),
//           title: Text(business.email),
//           onTap: () {
//             // Handle sending email
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.share),
//           title: Text('Share'),
//           onTap: () {
//             // Handle sharing business details
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.favorite_border),
//           title: Text('Add to Favorites'),
//           onTap: () {
//             // Handle adding to favorites
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.facebook),
//           title: Text(business.socialMedia.isNotEmpty ? business.socialMedia : 'Facebook'),
//           onTap: () {
//             // Handle opening social media
//           },
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Description',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             business.description,
//             style: const TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Gallery',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: business.galleryImages.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: Image.network(
//                   business.galleryImages[index],
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
