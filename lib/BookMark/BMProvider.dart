
import 'package:abrin_app_new/BookMark/BMmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookmarkProvider with ChangeNotifier {
  List<BookmarkedBusiness> _bookmarkedBusinesses = [];

  List<BookmarkedBusiness> get bookmarkedBusinesses => _bookmarkedBusinesses;

  Future<void> addBookmark(BookmarkedBusiness business) async {
    final url = Uri.parse('https://srv562456.hstgr.cloud/api/business/${business.id}/favorite');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        if (!_bookmarkedBusinesses.any((b) => b.id == business.id)) {
          _bookmarkedBusinesses.add(business);
          notifyListeners();
        }
      } else {
        print('Failed to bookmark the business');
      }
    } catch (error) {
      print('Error bookmarking the business: $error');
    }
  }

  void removeBookmark(int id) {
    _bookmarkedBusinesses.removeWhere((business) => business.id == id);
    notifyListeners();
  }
}
