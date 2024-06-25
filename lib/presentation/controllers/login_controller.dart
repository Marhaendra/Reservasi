import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var loginUser = <LoginResponse>[].obs;

  void postLogin({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      final response = await _apiService.login(body);

      // Ensure the response is not null and has valid data
      if (response != null &&
          response.token.isNotEmpty &&
          response.userData != null) {
        loginUser.add(response);

        // Debugging logs
        print('Login successful: $response');
        print('Token: ${response.token}');
        print('User ID: ${response.userData.id}');
        print('User Name: ${response.userData.name}');

        // Save token to SharedPreferences
        await UserManager.saveToken(response.token);
        await UserManager.saveId(response.userData.id);
        await UserManager.saveNama(response.userData.name);
      } else {
        print('Invalid login response');
      }
    } catch (e) {
      // Handle error
      print('Error during login: $e');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Call the API method to initiate Google Sign-In
      await _apiService.loginGoogle();

      // Typically, after calling loginGoogle(), the OAuth flow will open a web view
      // or browser window where users can select their Google account and authenticate.
      // You handle the callback in handleGoogleLoginCallback().
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> handleGoogleLoginCallback(String code) async {
    try {
      final response = await _apiService.loginGoogleCallback(code);

      if (response != null &&
          response.token.isNotEmpty &&
          response.data != null) {
        // Handle successful login response
        print('Login successful with Google:');
        print('User data: ${response.data}');
        print('Token: ${response.token}');

        // Save token to SharedPreferences or manage as needed
        await UserManager.saveToken(response.token);
        await UserManager.saveId(response.data.id);
        await UserManager.saveNama(response.data.name);

        // Navigate to desired screen after successful login
        Get.offAllNamed('/home'); // Replace with your home screen route
      } else {
        print('Invalid login response');
      }
    } catch (e) {
      print('Error handling Google login callback: $e');
    }
  }
}
