import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/features/data/models/user_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var loginUser = <LoginResponse>[].obs;
  var userData = <UserModel>[].obs;

  Future<void> getUserData() async {
    try {
      final token = await UserManager.getToken();
      final id = await UserManager.getUserId();
      print("getUserData");

      if (token == null || id == null) {
        print('Token or User ID is null');
        return;
      }

      final response = await _apiService.getUserById(token, id);

      if (response != null && response.data.isNotEmpty) {
        final user = response.data.first;
        userData.add(user);

        // Debugging logs
        print('status : ${user.status}');
        print('userData: $userData');

        // Save status to SharedPreferences
        await UserManager.saveStatus(user.status);
      } else {
        print('Invalid login response or empty data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await UserManager.saveIsGoogleSignIn(false);

      print('signOutGoogle');
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  Future<void> signInGoogle() async {
    try {
      print('Starting Google sign-in');
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        print('Google sign-in aborted');
        return;
      }

      print('Google sign-in successful');
      final String? authCode = gUser.serverAuthCode;
      print('authCode: $authCode');

      if (authCode != null) {
        print('Sending authCode to backend');
        final response = await _apiService.loginGoogleCallback(authCode);

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
          await UserManager.saveIsGoogleSignIn(true);
          // Navigate to desired screen after successful login
          Get.offAllNamed('/home'); // Replace with your home screen route
        } else {
          print('Invalid login response');
        }
      } else {
        print('Failed to get authCode from Google');
      }
    } catch (error) {
      print('Error during Google login: $error');
    }
  }

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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
    serverClientId:
        '296555994363-c3g3ttla97hmn749d326ttg56dulhguh.apps.googleusercontent.com',
  );
}
