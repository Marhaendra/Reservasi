import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AppDatabase _database = Get.find<AppDatabase>();
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
      await UserManager.saveId(response.id);
      await UserManager.saveNama(response.nama);
      // Save login data to local database
      await _database.loginDao.insertLogin(response);
      print('Raw response data: $response');
      // Fetch user data (optional)
      final userData = await _database.loginDao.getUserData();
      userData.forEach((user) {
        print('User Data: ${user.toJson()}');
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
