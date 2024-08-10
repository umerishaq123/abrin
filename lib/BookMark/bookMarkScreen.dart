
import 'package:abrin_app_new/BookMark/BMProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkedScreen extends StatelessWidget {
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
              return ListTile(
                leading: Image.network(business.coverPicture),
                title: Text(business.name),
                subtitle: Text(business.category),
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
