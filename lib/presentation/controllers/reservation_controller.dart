import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
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

  final ApiService _apiService;
  final AppDatabase _database;

  ReservationController(this._apiService, this._database);

  @override
  void onInit() {
    super.onInit();
    fetchPeriodSeats();
    initializeSession();
  }

  void reservation() async {}

  void fetchPeriodSeats() async {
    try {
      // Retrieve the token
      final token = await UserManager.getToken();

      // Fetch room periods
      RoomsPeriodResponse roomsPeriodResponse =
          await _apiService.getRuanganPeriode(token!);
      periodRooms.value = roomsPeriodResponse.data;

      // Retrieve CalendarController instance
      final CalendarController calendarController =
          Get.find<CalendarController>();

      // Get the selected day and format it
      DateTime selectedDay = calendarController.selectedDay;
      String tanggalReservasi = DateFormat('yyyy-MM-dd').format(selectedDay);

      // Retrieve RoomsSeatsController instance
      final RoomsSeatsController roomsSeatsController =
          Get.find<RoomsSeatsController>();

      // Get the selected room ID
      int ruanganId = roomsSeatsController.selectedRoomId.value;

      // Example value for periodeId
      int periodeId = 1; // Replace with actual value as needed

      // Fetch available seats
      SeatsResponse seatsResponse = await _apiService.getAvailableKursi(
        token,
        tanggalReservasi,
        ruanganId,
        periodeId,
      );
      seats.value = seatsResponse.data;
    } catch (error) {
      // Handle the error
      print('error reservationcontroller');
    }
  }

  void initializeSession() async {
    // Retrieve the session length from the database asynchronously
    var seat = await _database.seatsDao.findAllSeats();
    var kursiQ = seat.length;
    int seatLength = kursiQ;

    var period = await _database.roomsPeriodDao.findAllRoomsPeriod();
    Set<int> periodIds = period.map((period) => period.periode_id).toSet();
    var periode = periodIds.length;
    int periodLength = periode;

    print('kursiList: $seat, kursiQ: $kursiQ, period: $period');
    // Generate the session list
    generateSessionList(periodLength, seatLength);

    // Listen for changes in the database and update session list accordingly
    _database.seatsDao.watchAllSeats().listen((updatedSeats) {
      var newKursiQ = updatedSeats.length;
      if (newKursiQ != kursiQ) {
        // If the number of seats has changed, update the session list
        kursiQ = newKursiQ;
        session.clear(); // Clear the existing session list
        generateSessionList(periodLength, kursiQ); // Generate new session list
      }
    });
    _database.roomsPeriodDao.watchAllRoomsPeriod().listen((updateRoomsPeriod) {
      var newPeriode = updateRoomsPeriod.length;
      if (newPeriode != periode) {
        // If the number of periods has changed, update the session list
        periode = newPeriode;
        session.clear(); // Clear the existing session list
        generateSessionList(periode, kursiQ); // Generate new session list
      }
    });
  }

  void generateSessionList(int periodLength, int seatLength) {
    // Generate the session list based on the session length
    session.value = List.generate(
      periodLength,
      (indexSession) => List<Map<String, dynamic>>.generate(
        seatLength,
        (indexSeat) {
          final isFilled = indexSession == 0
              ? (indexSeat >= 24 && indexSeat <= 26) ||
                  (indexSeat >= 40 && indexSeat <= 44)
              : indexSession == 1
                  ? (indexSeat >= 5 && indexSeat <= 35)
                  : false;

          return {
            "id": "ID-${indexSession + 1}-${indexSeat + 1}",
            "status": isFilled ? "filled" : "available",
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
    selectedSeats.clear(); // Clear the list of selected seats
  }

  void changeSession(int indexSessionSelected) {
    indexSession.value = indexSessionSelected;
    session.refresh();
  }

  void selectSeat(int indexSeatSelected) {
    final seat = session[indexSession.value][indexSeatSelected];

    if (seat["status"] == "selected") {
      // Deselect the seat on double tap
      seat["status"] = "available";
      seat["isSelected"] = false;
      selectedSeats.remove(seat["id"] as String);
    } else if (seat["status"] == "available" && selectedSeats.length < 4) {
      // Select the seat if it's available and not already selected
      seat["status"] = "selected";
      seat["isSelected"] = true;
      selectedSeats.add(seat["id"] as String);
    }
    session.refresh();
    print(
        "Session ${indexSession.value + 1}, Seat ${indexSeatSelected + 1}: $seat");
  }

  void orderSeat() {
    // Store the selected seats for the current session
    reservedSeat.assignAll(selectedSeats);

    // Mark selected seats as "reserved" in the session
    session[indexSession.value].forEach((seat) {
      if (selectedSeats.contains(seat["id"] as String)) {
        seat["status"] = "reserved";
      }
    });

    // Print the selected seats for confirmation (you can remove this line if not needed)
    print("Reserved Seats: $reservedSeat");

    print("Reserved Date: $reservedDate");

    // Clear the selected seats list
    // selectedSeats.clear();

    // Refresh the session
    // session.refresh();
  }

  void clearReservedSeatsAndDate() {
    reservedSeat.clear();
    reservedDate.value = "";
  }

  bool isSeatSelected() {
    return selectedSeats.isNotEmpty;
  }
}
