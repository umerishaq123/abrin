// business_service.dart
import 'dart:convert';


import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:http/http.dart' as https;

class BusinessService {
 
  Future<List<Business>> fetchBusinesses() async {
    final response = await https
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
}
