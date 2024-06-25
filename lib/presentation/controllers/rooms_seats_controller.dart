import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/combined_room_model.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';
import 'package:reservasi/helper/reservation_manager.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/rooms_period_contoller.dart';

class RoomsSeatsController extends GetxController {
  RxString selectedRoom = "Ruang".obs;
  RxInt selectedRoomId = 0.obs;
  RxList<RoomsModel> rooms = <RoomsModel>[].obs;
  RxList<SeatsModel> seats = <SeatsModel>[].obs;
  RxList<SeatsModel> seatList = <SeatsModel>[].obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;
  RxList<CombinedRoomModel> combinedRooms = <CombinedRoomModel>[].obs;

  final ApiService _apiService;
  // final AppDatabase _database;

  RoomsSeatsController(this._apiService);

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

      // Debugging prints
      combinedRooms.forEach((combinedRoom) {
        // print(
        //     'Room: ${combinedRoom.room.nama_ruangan} (ID: ${combinedRoom.room.ruangan_id})');
        // print('Seats:');
        combinedRoom.seats.forEach((seat) {
          // print(
          //     'ID: ${seat.kursi_id}, isBroken: ${seat.isBroken}, nomor_kursi: ${seat.nomor_kursi}');
        }); // Add an empty line for better readability
      });

      // Save rooms to local database
      // await _database.roomsDao.insertRooms(rooms);

      // Save seats to local database
      // await _database.seatsDao.insertSeats(seats);
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch rooms or seats: $error');
      print('Error: $error');
    }
  }

  void updateRoomSeat(String roomName, int roomId) async {
    selectedRoom.value = roomName;
    selectedRoomId.value = roomId;

    // Find and print the selected room and its seats
    final selectedCombinedRoom = combinedRooms.firstWhere(
        (combinedRoom) => combinedRoom.room.ruangan_id == roomId,
        orElse: () => CombinedRoomModel(
            room: RoomsModel(ruangan_id: 0, nama_ruangan: ''), seats: []));

    if (selectedCombinedRoom.room.ruangan_id != 0) {
      print(
          'Room: ${selectedCombinedRoom.room.nama_ruangan} (ID: ${selectedCombinedRoom.room.ruangan_id})');
      print('Seats:');
      selectedCombinedRoom.seats.forEach((seat) {
        print('ID: ${seat.kursi_id}');
      });
      print(
          'Total Seats: ${selectedCombinedRoom.seats.length}'); // Add an empty line for better readability

      seatList.assignAll(selectedCombinedRoom.seats);
      // Delete existing values from the database

      // await _database.roomsPeriodDao.deleteAllRoomsPeriod();
      // await _database.seatsDao.deleteAllSeats();
      // await _database.roomsDao.deleteAllRooms();

      // Save the selected room and its seats to the local database using REPLACE strategy
      // await _database.roomsDao.insertRoom(selectedCombinedRoom.room);
      // await _database.seatsDao.insertSeats(selectedCombinedRoom.seats);
    } else {
      print('No room found with ID: $roomId');
    }

    await ReservationManager.clear();
    await ReservationManager.saveRuanganId(roomId);
    await ReservationManager.saveKursiQ(selectedCombinedRoom.seats.length);

    final ruanganId = await ReservationManager.getRuanganId();
    final kursiQ = await ReservationManager.getKursiQ();
    print('ruanganId: $ruanganId, kursi $kursiQ');

    final RoomsPeriodController roomsPeriodController =
        Get.find<RoomsPeriodController>();
    roomsPeriodController.getRuanganPeriode();
    update();
  }

  void reset() {
    selectedRoom.value = "Ruang";
    selectedRoomId.value = 0;
    update();
  }

  // void fetchRoomPeriod() async {
  //   try {
  //     final token = await UserManager.getToken();
  //     RoomsPeriodResponse roomsPeriodResponse =
  //         await _apiService.getRuanganPeriode(token!);

  //     final RoomsSeatsController roomsSeatsController =
  //         Get.find<RoomsSeatsController>();
  //     int ruanganId = roomsSeatsController.selectedRoomId.value;

  //     // Filter the periods based on ruangan_id and is_active
  //     periodRooms.value = roomsPeriodResponse.data
  //         .where((period) =>
  //             period.ruangan_id == ruanganId && period.is_active == 1)
  //         .toList(); // Log the filtered periods

  //     // Save the filtered periods to the DAO and notify listeners
  //     await _database.roomsPeriodDao.insertAndNotify(periodRooms.value);
  //     print('periodROOM: $periodRooms');

  //     // // Verify that data has been inserted
  //     // List<RoomsPeriodModel> allPeriods =
  //     //     await _database.roomsPeriodDao.findAllRoomsPeriod();
  //     // print('All periods from DB: $allPeriods');
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to fetch room period: $error');
  //     print('Error: $error');
  //   }
  // }
}
