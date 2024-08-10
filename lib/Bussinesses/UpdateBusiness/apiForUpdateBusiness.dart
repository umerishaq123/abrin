import 'dart:convert';
import 'dart:io';


import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = 'https://srv562456.hstgr.cloud/api/business';

  Future<http.Response> updateBusiness(
      int businessId, String token, Business business) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/:id'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: '$token',
        },
        body: json.encode(business.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update business');
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
