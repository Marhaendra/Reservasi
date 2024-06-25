import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/rooms_seats_controller.dart';

class RoomsPeriodController extends GetxController {
  RxInt periodLength = 0.obs;
  RxList<int> periodList = <int>[].obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;

  // final AppDatabase _appDatabase;
  final ApiService _apiService;
  // List<RoomsPeriodModel> periods = [].obs;

  RoomsPeriodController(this._apiService);

  @override
  void onInit() {
    super.onInit();
    fetchRoomsPeriod();
  }

  void getRuanganPeriode() async {
    try {
      final token = await UserManager.getToken();
      RoomsPeriodResponse roomsPeriodResponse =
          await _apiService.getRuanganPeriode(token!);

      final RoomsSeatsController roomsSeatsController =
          Get.find<RoomsSeatsController>();
      int ruanganId = roomsSeatsController.selectedRoomId.value;

      // Filter the periods based on ruangan_id and is_active
      periodRooms.value = roomsPeriodResponse.data
          .where((period) =>
              period.ruangan_id == ruanganId && period.is_active == 1)
          .toList(); // Log the filtered periods
      print('periodROOM: $periodRooms');
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchRoomsPeriod() async {
    try {
      // Fetch rooms period data from DAO
      // final roomsPeriod =
      //     await _appDatabase.roomsPeriodDao.findAllRoomsPeriod();
      // periodRooms.assignAll(roomsPeriod);

      // Extract periode_id values and assign to periodList
      getRuanganPeriode();
      periodList.assignAll(periodRooms.map((room) => room.periode_id));

      periodLength.value = periodRooms.length;
      print('periodList: $periodList, periodLength: $periodLength');
    } catch (error) {
      // Handle error if any
      print('Error fetching rooms period: $error');
    }
  }

  Future<List<int>> fetchRoomPeriodList() async {
    await fetchRoomsPeriod();
    return periodList;
  }

  void filterRoomsByPeriodeId(int periodeId) {
    final filteredRooms =
        periodRooms.where((room) => room.periode_id == periodeId).toList();
    periodRooms.assignAll(filteredRooms);
    periodLength.value = filteredRooms.length;
  }

  Future<List<String>> getSessionTimes() async {
    await fetchRoomsPeriod(); // Ensure data is fetched before generating session times
    List<String> sessionTimes = periodRooms
        .map((room) => "${room.jam_mulai} - ${room.jam_selesai}")
        .toList(); // Ensure data is fetched before generating session times
    List<String> sessionNames =
        periodRooms.map((room) => "${room.nama_periode}").toList();

    // Print the session times

    print('Session Times: $sessionTimes = $sessionNames');

    return sessionTimes;
  }

  Future<List<String>> getSessionNames() async {
    await fetchRoomsPeriod(); // Ensure data is fetched before generating session times
    List<String> sessionNames =
        periodRooms.map((room) => "${room.nama_periode}").toList();

    // Print the session times

    print('Session Names: $sessionNames');

    return sessionNames;
  }

  Future<List<int>> getMissedSessionPeriod() async {
    await fetchRoomsPeriod(); // Ensure data is fetched before generating session periods

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    List<int> missedSessionPeriods = periodRooms
        .where((room) {
          DateTime jamMulai = DateTime(
            today.year,
            today.month,
            today.day,
            int.parse(room.jam_mulai.split(':')[0]),
            int.parse(room.jam_mulai.split(':')[1]),
            int.parse(room.jam_mulai.split(':')[2]),
          );
          DateTime jamSelesai = DateTime(
            today.year,
            today.month,
            today.day,
            int.parse(room.jam_selesai.split(':')[0]),
            int.parse(room.jam_selesai.split(':')[1]),
            int.parse(room.jam_selesai.split(':')[2]),
          );

          print('jamMulai: $jamMulai');
          print('jamSelesai: $jamSelesai');

          // Check if jamMulai is before now
          return jamMulai.isBefore(now);
        })
        .map((room) => room.periode_id)
        .toList();
    print('now: $now');
    print('periodRooms: $periodRooms');
    print('Missed Session Periods: $missedSessionPeriods');

    return missedSessionPeriods;
  }
}
