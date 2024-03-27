import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/login_model.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  var loginUser = RxList<LoginModel?>();
  var tokenlog = "token";

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

      final token = response.token;
      tokenlog = token;
      print('Token: $token');
      print("$tokenlog");
    } catch (e) {
      // Handle error
    }
  }
}
