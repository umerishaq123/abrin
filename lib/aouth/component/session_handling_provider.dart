import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHandlingViewModel with ChangeNotifier {
  
  // Method to save token
  Future<bool> saveToken(var token) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('Authorization', token);
      // notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving token: $e');
      return false; // Token not saved
    }
  }

  // Method to get token
  Future<String?> getToken() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? token = sp.getString('Authorization');
      print("::: the token is here in session : $token");
      // notifyListeners();
      return token;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }


  
    Future removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('Authorization');
    // notifyListeners();
    return sp.clear();
  }
}
