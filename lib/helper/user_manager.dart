import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static const _keyToken = 'token';
  static const _keyUserId = 'userId';
  static const _keyNama = 'nama';

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
