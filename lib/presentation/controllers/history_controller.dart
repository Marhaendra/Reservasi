import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/reservation_get_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class HistoryController extends GetxController {
  RxList<ReservationGetModel> allReservationById = <ReservationGetModel>[].obs;

  final ApiService _apiService;

  HistoryController(this._apiService);

  Future<void> getAllReservasiById() async {
    try {
      final token = await UserManager.getToken();
      final id = await UserManager.getUserId();

      if (token == null || id == null) {
        print('Token or ID is null');
        return;
      }

      print('Token in getReservasiById: $token');
      print('ID in getReservasiById: $id');

      ReservationGetResponse reservationGetResponse =
          await _apiService.getReservasiById(token, id);

      allReservationById.value = reservationGetResponse.data.toList();
      var length = allReservationById.length;
      print('all: $length');
    } catch (error) {
      print('Error fetching reservations: $error');
    }
  }
}
