
import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessService {
  final String baseUrl = 'https://213.130.147.72:5000/api/business';

  Future<List<Business>> fetchBusinesses() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Business.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }

  Future<void> addReview(int businessId, Map<String, dynamic> review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$businessId/review'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(review),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add review');
    }
  }

  Future<void> addCommentToReview(int reviewId, Map<String, dynamic> comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/review/$reviewId/comment'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(comment),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> addBusinessToFavorites(int businessId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$businessId/favorite'),
      headers: {'Authorization': 'Bearer your_token_here'}, // Add token handling
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add business to favorites');
    }
  }
}
