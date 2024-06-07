import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/combined_room_model.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';
import 'package:reservasi/helper/user_manager.dart';

class RoomsSeatsController extends GetxController {
  RxString selectedSpace = "Ruang".obs;
  RxList<RoomsModel> rooms = <RoomsModel>[].obs;
  RxList<SeatsModel> seats = <SeatsModel>[].obs;
  RxList<CombinedRoomModel> combinedRooms = <CombinedRoomModel>[].obs;

  final ApiService _apiService;
  final AppDatabase _database;

  RoomsSeatsController(this._apiService, this._database);

  @override
  void onInit() {
    super.onInit();
    fetchCombinedRooms();
  }

  void fetchCombinedRooms() async {
    try {
      final token = await UserManager.getToken();

      // Fetch rooms
      RoomsResponse roomsResponse = await _apiService.getRuangan(token!);
      rooms.value = roomsResponse.data;

      // Fetch seats
      SeatsResponse seatsResponse = await _apiService.getKursi(token);
      seats.value = seatsResponse.data;

      // Combine rooms and seats based on ruangan_id
      combinedRooms.value = rooms.map((room) {
        var roomSeats =
            seats.where((seat) => seat.ruangan_id == room.ruangan_id).toList();
        return CombinedRoomModel(room: room, seats: roomSeats);
      }).toList();

      // Print combined rooms and seats
      combinedRooms.forEach((combinedRoom) {
        print(
            'Room: ${combinedRoom.room.nama_ruangan} (ID: ${combinedRoom.room.ruangan_id})');
        print('Seats:');
        combinedRoom.seats.forEach((seat) {
          print('ID: ${seat.kursi_id}');
        });
        print(''); // Add an empty line for better readability
      });

      // Save rooms to local database
      await _database.roomsDao.insertRooms(rooms);

      // Save seats to local database
      await _database.seatsDao.insertSeats(seats);
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch rooms or seats: $error');
    }
  }

  void updateRoom(String roomName) {
    selectedSpace.value = roomName;
    update();
  }

  void reset() {
    selectedSpace.value = "Ruang";
    update();
  }
}
