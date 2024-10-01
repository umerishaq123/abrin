// import 'package:abrin_app_new/BookMark/BMProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BookmarkedScreen extends StatefulWidget {
//   @override
//   State<BookmarkedScreen> createState() => _BookmarkedScreenState();
// }

// class _BookmarkedScreenState extends State<BookmarkedScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'Entreprises mises en favoris',
//           style: TextStyle(color: Colors.blue),
//         ),
//       ),
//       body: Consumer<BookmarkProvider>(
//         builder: (context, bookmarkProvider, child) {
//           print(":::: the business in list of screen:${bookmarkProvider.bookmarkedBusinesses}");
//           if (bookmarkProvider.bookmarkedBusinesses.isEmpty) {
//             return Center(
//                 child: Text(
//               'Aucune entreprise n\'a encore\n   été ajoutée à vos favoris',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ));
//           }
//           return ListView.builder(
//             itemCount: bookmarkProvider.bookmarkedBusinesses.length,
//             itemBuilder: (context, index) {
//               final business = bookmarkProvider.bookmarkedBusinesses[index];
//               print("::: print 1");
//               return ListTile(
//                 leading: Image.network(business.coverPicture),
//                 // title: Text(business.name),
//                                 title: Text('hello umer'),

//                 subtitle: Text('independence day'),
//                 trailing: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     bookmarkProvider.removeBookmark(business.id);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Modelclass{
// final String title;
// final String subtitle;
// final Icon icons;

// Modelclass({ required this.title,required this.subtitle,required this.icons});

// }

import 'package:abrin_app_new/BookMark/BMDetalScreen.dart';
import 'package:abrin_app_new/BookMark/BMProvider.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class BookmarkedScreen extends StatefulWidget {
  @override
  State<BookmarkedScreen> createState() => _BookmarkedScreenState();
}

class _BookmarkedScreenState extends State<BookmarkedScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookmarkProvider>(context, listen: false)
          .fetchBookmarkedBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Entreprises mises en favoris',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          Utils.dismissKeyboard(context);
        },
        child: Consumer<BookmarkProvider>(
          builder: (context, bookmarkProvider, child) {
            print(
                ":::: the business in list of screen:${bookmarkProvider.bookmarkedBusinesses}");
            if (bookmarkProvider.bookmarkedBusinesses.isEmpty) {
              return Center(
                  child: Text(
                'Aucune entreprise n\'a encore\n   été ajoutée à vos favoris',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ));
            }
            return ListView.builder(
              itemCount: bookmarkProvider.bookmarkedBusinesses.length,
              itemBuilder: (context, index) {
                final business = bookmarkProvider.bookmarkedBusinesses[index];
                print("::: print 1");
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsScreen(
                          customRating: CustomRating(
                            coverPicture: business.coverPicture,
                            type: business.category,
                            name: business.name,
                            address: business.location,
                            description: business.description,
                            profilePicture: business.profilePicture,
                            isVerified: business.isVerified,
                            phone: business.phone,
                            website: business.website,
                            socialMedia: business.socialMedia,
                            email: business.email,
                            id: business.id,
                            city: business.city,
                          ),
                          bottomModel: BottomModel(
                              title: business.name,
                              image: business.coverPicture,
                              message: business.category,
                              time: business.name),
                          businessId: business.id,
                        ), // Replace `NextPage` with your page widget
                      ),
                    );
                  },
                  leading: Container(
                    height: height * 0.1,
                    child: Image.network(
                      business.profilePicture,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  //  Image.network(
                  //   business.profilePicture,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     return Icon(Icons
                  //         .error); // Display an error icon if the image fails to load
                  //   },
                  // ),
                  title: Text(business.name), // Display the business name
                  subtitle: Text(
                    business.description,
                    overflow:
                        TextOverflow.ellipsis, // Truncate text with ellipsis
                    maxLines: 1, // Limit to one line
                    style: TextStyle(
                      color: Colors.grey, // Optional: Adjust text color or style
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      bookmarkProvider.removeBookmark(business.id);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
