import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/edit_profile_model.dart';
import 'package:reservasi/helper/user_manager.dart';

// Import the EditProfileResponse model

class ProfileController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  RxList<EditProfileModel> userUpdate = <EditProfileModel>[].obs;

  Future<void> postEditProfile({
    required String nama,
    required String no_telepon,
  }) async {
    try {
      final token = await UserManager.getToken();
      print('Token retrieved: $token');

      int id = (await UserManager.getUserId())!;

      final body = {
        'nama': nama,
        'no_telepon': no_telepon,
      };

      // Call the API service to edit the profile
      EditProfileResponse editProfileResponse =
          await _apiService.editProfil(token!, id, body);

      // Check if the response contains data
      if (editProfileResponse.data != null) {
        // Update the userUpdate list with the data from the response
        userUpdate.assignAll([editProfileResponse.data!]);

        // Accessing the updated 'nama' from the first item in the list
        String updatedNama = userUpdate.first.nama;

        // Save the updated 'nama' to UserManager
        await UserManager.saveNama(updatedNama);

        // Print success message
        print('userUpdate: $userUpdate - $updatedNama');
        print('Edit Profile completed successfully! $editProfileResponse');
      } else {
        print('Edit profile response is empty.');
      }
    } catch (error) {
      print('Error in postEditProfile: $error');
    }
  }
}
