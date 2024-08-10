

import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  print('Retrieved token: $token');
  return token;
}
