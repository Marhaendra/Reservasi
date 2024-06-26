import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static const _keyToken = 'token';
  static const _keyUserId = 'userId';
  static const _keyNama = 'nama';
  static const _keyStatus = 'status';
  static const _keyGoogleSignIn = 'googleSignIn';

  static RxString nama = ''.obs;

  // Save token to SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  static Future<void> saveId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
  }

  static Future<void> saveNama(String nama) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNama, nama);
  }

  static Future<void> saveStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStatus, status);
  }

  static Future<void> saveIsGoogleSignIn(bool isGoogleSignIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyGoogleSignIn, isGoogleSignIn);
  }

  // Retrieve token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  static Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNama);
  }

  static Future<String?> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyStatus);
  }

  static Future<bool?> getIsGoogleSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyGoogleSignIn);
  }

  static Future<void> initializeNama() async {
    final prefs = await SharedPreferences.getInstance();
    UserManager.nama.value = prefs.getString(_keyNama) ?? '';
  }

  // Remove token from SharedPreferences (Logout)
  static Future<void> clearUserManager() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
      _keyToken,
    );
    await prefs.remove(
      _keyUserId,
    );
    await prefs.remove(
      _keyNama,
    );
    await prefs.remove(
      _keyStatus,
    );
    UserManager.nama.value = '';
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
