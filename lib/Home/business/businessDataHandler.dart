// business_service.dart
import 'dart:convert';
import 'dart:math';


import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BusinessService {
  
 
  Future<List<Business>> fetchBusinesses() async {
    final response = await http
        .get(Uri.parse('https://srv562456.hstgr.cloud/api/business/all'));
print("::: the response of all bussinus is :${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
     data.forEach((json) {
        final email = json['email'];
        print('Business Email: $email');
      });
      return data.map((json) => Business.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load businesses${response.statusCode}');
    }
  }


// Future<List<Business>> fetchBusinesses() async {
//   final response = await http.get(Uri.parse('https://srv562456.hstgr.cloud/api/business/all'));
  
//   // Print the full response body to verify
//   print("Response body: ${response.body}");
//   print("Response status: ${response.statusCode}");


//   if (response.statusCode == 200) {
//     try {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Business.fromJson(json)).toList();
//     } catch (e) {
//       print("Error decoding JSON: $e");
//       throw Exception('Failed to parse businesses data');
//     }
//   } else {
//     print('Failed to load businesses with status code ${response.statusCode}');
//     throw Exception('Failed to load businesses');
//   }
// }
 // for kDebugMode




//   Future<List<Business>> fetchAllBusinesses() async {
//     try {
//       final response = await http.get(Uri.parse('https://srv562456.hstgr.cloud/api/business/all'));
// print(":::: the response isn:${response.body}");
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((json) => Business.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load businesses: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching businesses: $e');
//     }
//   }

//    Future<List<Business>> fetchAllBusinesses() async {
//     try {
//       final response = await http.get(Uri.parse('https://srv562456.hstgr.cloud/api/business/all'));
// print(":::: the response isn:${response.body}");
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((json) => Business.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load businesses');
//       }
//     } catch (e) {
//       print('Error fetching businesses: $e');
//       return [];
//     }
//   }


}
