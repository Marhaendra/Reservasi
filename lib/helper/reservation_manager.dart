import 'package:shared_preferences/shared_preferences.dart';

class ReservationManager {
  static const _ruanganIdKey = 'ruanganId';
  static const _kursiQKey = 'kursiQ';

  // Save ruanganId to SharedPreferences
  static Future<void> saveRuanganId(int ruanganId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_ruanganIdKey, ruanganId);
  }

  // Save seats quantity to SharedPreferences
  static Future<void> saveKursiQ(int kursiQ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kursiQKey, kursiQ);
  }

  // Retrieve ruanganId from SharedPreferences
  static Future<int?> getRuanganId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_ruanganIdKey);
  }

  // Retrieve seats quantity from SharedPreferences
  static Future<int?> getKursiQ() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kursiQKey);
  }

  // Remove ruanganId from SharedPreferences
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ruanganIdKey);
    await prefs.remove(_kursiQKey);
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
