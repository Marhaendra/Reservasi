import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';

class RoomsPeriodController extends GetxController {
  RxInt periodLength = 0.obs;
  RxList<int> periodList = <int>[].obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;

  final AppDatabase _appDatabase;

  RoomsPeriodController(this._appDatabase);

  @override
  void onInit() {
    super.onInit();
    fetchRoomsPeriod();
  }

  Future<void> fetchRoomsPeriod() async {
    try {
      // Fetch rooms period data from DAO
      final roomsPeriod =
          await _appDatabase.roomsPeriodDao.findAllRoomsPeriod();
      periodRooms.assignAll(roomsPeriod);

      // Extract periode_id values and assign to periodList
      periodList.assignAll(roomsPeriod.map((room) => room.periode_id));

      periodLength.value = roomsPeriod.length;
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
        .toList();

    // Print the session times
    print('Session Times: $sessionTimes');

    return sessionTimes;
  }
}
