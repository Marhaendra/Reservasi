import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/register_model.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  var registerUser = RxList<RegisterModel>();

  Future<void> postRegister({
    required String nama,
    required String email,
    required String no_telepon,
    required String password,
  }) async {
    try {
      final body = {
        'nama': nama,
        'email': email,
        'no_telepon': no_telepon,
        'password': password,
      };

      final response = await _apiService.register(body);
      registerUser.add(response);
    } catch (e) {
      // Handle error
    }
  }
}
