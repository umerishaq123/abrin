import 'dart:convert';

import 'package:abrin_app_new/BookMark/BMmodel.dart';
import 'package:abrin_app_new/BookMark/addto_fav_model.dart';
import 'package:abrin_app_new/BookMark/fetchfav_bussines_model.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookmarkProvider with ChangeNotifier {
  
  List<FetchFavruitBussineses> _bookmarkedBusinesses = [];

  List<FetchFavruitBussineses> get bookmarkedBusinesses => _bookmarkedBusinesses;

  // Future<void> addBookmark(BookmarkedBusiness business) async {
  //   print("::: the bussines id is :${business.id}");
  //   final url = Uri.parse(
  //       'https://srv562456.hstgr.cloud/api/business/66b8f8b289b69bf7d9c6fda3/favorite');
  //   // api/business/66b8f8b289b69bf7d9c6fda3/favorite
  //   try {
  //     final response = await http.post(url);
  //     print("the fav items are hare:${response.body}");
  //     if (response.statusCode == 200) {
  //       if (!_bookmarkedBusinesses.any((b) => b.id == business.id)) {
  //         _bookmarkedBusinesses.add(business);
  //         notifyListeners();
  //       }
  //     } else {
  //       print('Failed to bookmark the business');
  //     }
  //   } catch (error) {
  //     print('Error bookmarking the business: $error');
  //   }
  // }

  void removeBookmark(String id) {
    _bookmarkedBusinesses.removeWhere((business) => business.id == id);
    notifyListeners();
  }



Future<void> addtoFav({required String businessId}) async {
  try {
    print("::: the id is print:$businessId");
    final token = await SessionHandlingViewModel().getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token is null or empty');
    }

    var headers = {
      'Authorization': ' $token',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://srv562456.hstgr.cloud/api/business/favorite');
    var body = json.encode({"businessId": '66b8f8b289b69bf7d9c6fda3'});

    var response = await http.post(url, headers: headers, body: body);

    print('Request URL: $url');
    print('Request Body: $body');
    print('Request Headers: $headers');

    if (response.statusCode == 200) {
      String responseBody = response.body;
      final result = addtofavFromJson(responseBody);
      print('Response Message: ${result.msg}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}





// Future<void> addtoFav({required var bussinesid}) async {
//   print(":::print the bussines id :$bussinesid");
//   final token=await SessionHandlingViewModel().getToken();
//   var headers = {
//     'Authorization': '$token',
//     'Content-Type': 'application/json'
//   };

//   var url = Uri.parse('https://srv562456.hstgr.cloud/api/business/$bussinesid/favorite');

//   // Empty body
//   var body = json.encode({});

//   try {
//     var response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       print('Response data: ${response.body}');
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//       print('Reason: ${response.reasonPhrase}');
//     }
//   } catch (e) {
//     print('An error occurred: $e');
//   }
// }


Future<void> fetchBookmarkedBusinesses() async {
  final token=await SessionHandlingViewModel().getToken();
  print("::: token for all bbbbb:$token");
    final headers = {
  'Authorization': ' $token',
    };

    final response = await http.get(
      Uri.parse('https://srv562456.hstgr.cloud/api/business/favorites'),
      headers: headers,
    );
    print("::: the response of alllllll:${response.body}");
   print('Request failed with status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      _bookmarkedBusinesses = jsonResponse
          .map((json) => FetchFavruitBussineses.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load favorites: ${response.reasonPhrase}');
    }
  }
}

///BookmarkedBusiness business