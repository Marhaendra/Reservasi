import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/reservation_post_model.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';
import 'package:reservasi/presentation/controllers/rooms_period_contoller.dart';
import 'package:reservasi/presentation/controllers/rooms_seats_controller.dart';

class ReservationController extends GetxController {
  RxList<List<Map<String, dynamic>>> session =
      <List<Map<String, dynamic>>>[].obs;
  RxList<SeatsModel> seats = <SeatsModel>[].obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;
  final RoomsPeriodController roomsPeriodController =
      Get.find<RoomsPeriodController>();

  var indexSession = 0.obs;
  var selectedSeats = <String>[].obs;
  var reservedSeat = <String>[].obs;
  var reservedDate = "".obs;
  var reservedSeatDate = <String>[].obs;
  var periodList = <int>[].obs;
  var reservation = <ReservationPostModel>[].obs;

  final ApiService _apiService;
  final AppDatabase _database;

  // Define the missing variables
  late int userId;
  late String nama;
  late String tanggalReservasi;
  late int ruanganId;
  late int periodeId;

  ReservationController(this._apiService, this._database);

  List<int> existingNomorKursi = [];

  @override
  void onInit() {
    super.onInit();

    initializeSession();
  }

  Future<void> postReservation() async {
    try {
      await fetchPeriodList();
      print('Starting postReservation...');

      final token = await UserManager.getToken();
      print('Token retrieved: $token');

      int userId = (await UserManager.getUserId())!;
      String nama = (await UserManager.getNama())!;

      print('User ID: $userId, Nama: $nama');

      final CalendarController calendarController =
          Get.find<CalendarController>();
      DateTime selectedDay = calendarController.selectedDay.value;
      String tanggalReservasi = DateFormat('yyyy-MM-dd').format(selectedDay);
      print('Tanggal Reservasi: $tanggalReservasi');

      // Match reserved seats with kursi_ids and nomor_kursis
      List<int> kursiIds = [];
      List<int> nomorKursis = [];
      for (String reservedSeats in reservedSeat) {
        int seatNumber = int.parse(reservedSeats.split('-').last);
        print(
            'Processing reserved seat: $reservedSeats, Seat number: $seatNumber');

        var matchedSeat =
            seats.firstWhere((seat) => seat.nomor_kursi == seatNumber);
        kursiIds.add(matchedSeat.kursi_id);
        nomorKursis.add(matchedSeat.nomor_kursi);
        print('Matched seat found: $matchedSeat');
      }
      print('Kursi IDs: $kursiIds');
      print('Nomor Kursis: $nomorKursis');

      final RoomsSeatsController roomsSeatsController =
          Get.find<RoomsSeatsController>();
      int ruanganId = roomsSeatsController.selectedRoomId.value;
      print('Ruangan ID: $ruanganId');

      int periodeId =
          periodList.isNotEmpty ? periodList[indexSession.value] : 0;
      print('Periode ID: $periodeId - $periodList');

      // Add a delay before the second loop
      await Future.delayed(Duration(seconds: 1));

// Make individual API calls for each kursi_id
      for (int i = 0; i < kursiIds.length; i++) {
        // Create a copy of userId and nama for this iteration
        final int currentUserId = userId;
        final String currentNama = nama;
        final String currenttanggalReservasi = tanggalReservasi;
        final int currentruanganId = ruanganId;
        final int currentperiodeId = periodeId;

        // Create a copy of body for this iteration
        Map<String, dynamic> body = {
          'user_id': currentUserId,
          'nama': currentNama,
          'tanggal_reservasi': currenttanggalReservasi,
          'kursi_id': kursiIds[i],
          'ruangan_id': currentruanganId,
          'nomor_kursi': nomorKursis[i],
          'periode_id': currentperiodeId,
        };

        // Add debug prints to check the structure of the body object
        print('Sending reservation request with body: $body');

        // Make the API call
        final response = await _apiService.reservasi(
          token!,
          body,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        reservation.add(response);
      }

      // Add a delay before starting the second loop
      await Future.delayed(Duration(seconds: 2));

      print('postReservation completed successfully!');
    } catch (error) {
      print('Error in postReservation: $error');
    }
  }

  Future<void> fetchPeriodList() async {
    try {
      periodList.value = await roomsPeriodController.fetchRoomPeriodList();
    } catch (error) {
      print('Error fetching period list: $error');
    }
  }

  Future<void> fetchAvailableKursi() async {
    try {
      await fetchPeriodList(); // Ensure period list is fetched first

      final token = await UserManager.getToken();
      final CalendarController calendarController =
          Get.find<CalendarController>();
      DateTime selectedDay = calendarController.selectedDay.value;
      String tanggalReservasi = DateFormat('yyyy-MM-dd').format(selectedDay);
      print('tanggalReservasi: $tanggalReservasi');

      final RoomsSeatsController roomsSeatsController =
          Get.find<RoomsSeatsController>();
      int ruanganId = roomsSeatsController.selectedRoomId.value;
      int periodeId =
          periodList.isNotEmpty ? periodList[indexSession.value] : 0;

      SeatsResponse seatsResponse = await _apiService.getAvailableKursi(
        token!,
        tanggalReservasi,
        ruanganId,
        periodeId,
      );
      seats.value = seatsResponse.data;
      print('periodeID: $periodeId - $indexSession ,periodList: $periodList');

      existingNomorKursi.clear();
      seats.forEach((seat) {
        existingNomorKursi.add(seat.nomor_kursi);
      });
      print('exKursi: $existingNomorKursi');
      // var authData = await _database.loginDao.getUserData();
      // print('authData: $authData');
    } catch (error) {
      print('error reservationcontroller: $error');
    }
  }

  Future<void> initializeSession() async {
    await fetchAvailableKursi();
    var seat = await _database.seatsDao.findAllSeats();
    int seatLength = seat.length;
    int periodLength = periodList.length;

    generateSessionList(periodLength, seatLength, existingNomorKursi);
  }

  void generateSessionList(
      int periodLength, int seatLength, List<int> existingNomorKursi) {
    session.value = List.generate(
      periodLength,
      (indexSession) => List<Map<String, dynamic>>.generate(
        seatLength,
        (indexSeat) {
          final isAvailable = existingNomorKursi.contains(indexSeat + 1);

          return {
            "id": "ID-${indexSession + 1}-${indexSeat + 1}",
            "status": isAvailable ? "available" : "filled",
            "isSelected": false,
          };
        },
      ),
    ).obs;
  }

  void ordered() {
    List<String> combinedList = [...reservedSeat, reservedDate.value];
    reservedSeatDate.addAll(combinedList);

    print("ordered: $reservedSeatDate");
  }

  void orderDate(String date) {
    reservedDate.value = date;
  }

  void reset() {
    for (var element in session) {
      for (var seat in element) {
        if (seat["status"] != "filled") {
          seat["status"] = "available";
          seat["isSelected"] = false;
        }
      }
    }
    selectedSeats.clear();
  }

  void changeSession(int indexSessionSelected) async {
    indexSession.value = indexSessionSelected;
    await fetchAvailableKursi();
    await initializeSession();
    session.refresh();
  }

  void selectSeat(int indexSeatSelected) {
    final seat = session[indexSession.value][indexSeatSelected];

    if (seat["status"] == "selected") {
      seat["status"] = "available";
      seat["isSelected"] = false;
      selectedSeats.remove(seat["id"] as String);
    } else if (seat["status"] == "available" && selectedSeats.length < 4) {
      seat["status"] = "selected";
      seat["isSelected"] = true;
      selectedSeats.add(seat["id"] as String);
    }
    session.refresh();
    print(
        "Session ${indexSession.value + 1}, Seat ${indexSeatSelected + 1}: $seat");
  }

  void orderSeat() {
    reservedSeat.assignAll(selectedSeats);
    session[indexSession.value].forEach((seat) {
      if (selectedSeats.contains(seat["id"] as String)) {
        seat["status"] = "reserved";
      }
    });

    print("Reserved Seats: $reservedSeat");
    print("Reserved Date: $reservedDate");
  }

  void clearReservedSeatsAndDate() {
    reservedSeat.clear();
    reservedDate.value = "";
  }

  bool isSeatSelected() {
    return selectedSeats.isNotEmpty;
  }
}
