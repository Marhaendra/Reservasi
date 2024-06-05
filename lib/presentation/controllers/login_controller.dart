import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/login_dao.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final LoginDao _loginDao = Get.find<LoginDao>();
  var loginUser = <LoginModel>[].obs;

  Future<void> postLogin({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      final response = await _apiService.login(body);
      loginUser.add(response);

      // Save token to SharedPreferences
      await UserManager.saveToken(response.token ?? '');

      // Save login data to local database
      await _loginDao.insertLogin(response);
      print('Raw response data: $response');
      // Fetch user data (optional)
      final userData = await _loginDao.getUserData();
      userData.forEach((user) {
        print('User Data: ${user.toJson()}');
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
