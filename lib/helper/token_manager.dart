import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const _keyToken = 'token';

  // Save token to SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // Retrieve token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }
}

// Example usage:
// Saving token:
// await TokenManager.saveToken('your_token_value');

// Retrieving token:
// final token = await TokenManager.getToken();
// if (token != null) {
//   print('Token: $token');
// } else {
//   print('Token not found');
// }
