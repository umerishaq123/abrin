
import 'dart:convert';

import 'package:http/http.dart' as http;

class BusinessServicesearch {
  static const String baseUrl = 'https://srv562456.hstgr.cloud/api/business';
  static const String searchUrl =
      'https://srv562456.hstgr.cloud/api/business/search';

  Future<List<Business>> fetchBusinesses() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Business.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }

  Future<List<Business>> searchBusinesses(
      {required double lat, required double lng, int radius = 2000}) async {
    final response = await http
        .get(Uri.parse('$searchUrl?lng=$lng&lat=$lat&radius=$radius'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Business.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }
}

class Business {
  final String name;
  final String coverPicture;
  final String category;
  final String location;
  final double rating;

  Business(
      {required this.name,
      required this.coverPicture,
      required this.category,
      required this.location,
      required this.rating});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'] ?? '',
      coverPicture: json['coverPicture'],
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }
}
