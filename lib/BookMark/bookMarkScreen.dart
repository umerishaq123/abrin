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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<BookmarkProvider>(
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
                      builder: (context) => BMDC(
                        business: business,
                      ), // Replace `NextPage` with your page widget
                    ),
                  );
                },
                leading: Image.network(
                  business.profilePicture,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons
                        .error); // Display an error icon if the image fails to load
                  },
                ),
                title: Text(business.name), // Display the business name
                subtitle: Text(business.description ?? 'No description'),
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
    );
  }
}
