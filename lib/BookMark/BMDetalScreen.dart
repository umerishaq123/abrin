
import 'package:abrin_app_new/BookMark/BMProvider.dart';
import 'package:abrin_app_new/BookMark/BMmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BMDC extends StatelessWidget {
  final BookmarkedBusiness business;

  const BMDC({Key? key, required this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(business.name),
        actions: [
          IconButton(
            icon: Icon(
              bookmarkProvider.bookmarkedBusinesses.any((b) => b.id == business.id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () {
              if (bookmarkProvider.bookmarkedBusinesses.any((b) => b.id == business.id)) {
                bookmarkProvider.removeBookmark(business.id);
              } else {
                bookmarkProvider.addBookmark(business);
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(business.coverPicture),
          SizedBox(height: 8),
          Text(business.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(business.category),
          Text(business.location),
          // other details...
        ],
      ),
    );
  }
}
