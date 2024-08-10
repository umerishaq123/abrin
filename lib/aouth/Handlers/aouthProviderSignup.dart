
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class AuthProvider with ChangeNotifier {
  String _otp = '';
  String _email = '';

  String get otp => _otp;
  String get email => _email;

  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/register');
    final response = await https.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    print('Register response status: ${response.statusCode}');
    print('Register response body: ${response.body}');

    if (response.statusCode == 200) {
      _email = email;
      notifyListeners();
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> verifyOtp(String otp) async {
    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/verify-otp');
    final response = await https.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': _email, 'otp': otp}),
    );

    print('Verify OTP response status: ${response.statusCode}');
    print('Verify OTP response body: ${response.body}');

    if (response.statusCode == 200) {
      _otp = otp;
      notifyListeners();
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<void> resendOtp() async {
    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/resend-otp');
    final response = await https.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': _email}),
    );

    print('Resend OTP response status: ${response.statusCode}');
    print('Resend OTP response body: ${response.body}');

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to resend OTP');
    }
  }
}