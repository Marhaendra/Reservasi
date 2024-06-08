import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/models/seats_model.dart';

class ReservationController extends GetxController {
  late RxList<List<Map<String, dynamic>>> session;
  RxList<SeatsModel> seats = <SeatsModel>[].obs;

  var indexSession = 0.obs;
  var selectedSeats = <String>[].obs;
  var reservedSeat = <String>[].obs;
  var reservedDate = "".obs;
  var reservedSeatDate = <String>[].obs;

  final AppDatabase _database;

  ReservationController(this._database);

  @override
  void onInit() {
    super.onInit();
    // Initialize the session
    initializeSession();
  }

  void initializeSession() async {
    // Retrieve the session length from the database asynchronously
    var seat = await _database.seatsDao.findAllSeats();
    var kursiQ = seat.length;
    int sessionLength = kursiQ;
    print('kursiList: $seat, kursiQ: $kursiQ');
    // Generate the session list
    generateSessionList(sessionLength);

    // Listen for changes in the database and update session list accordingly
    _database.seatsDao.watchAllSeats().listen((updatedSeats) {
      var newKursiQ = updatedSeats.length;
      if (newKursiQ != kursiQ) {
        // If the number of seats has changed, update the session list
        kursiQ = newKursiQ;
        session.clear(); // Clear the existing session list
        generateSessionList(kursiQ); // Generate new session list
      }
    });
  }

  void generateSessionList(int sessionLength) {
    // Generate the session list based on the session length
    session = List.generate(
      4,
      (indexSession) => List<Map<String, dynamic>>.generate(
        sessionLength,
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
    session.forEach((element) {
      element.forEach((element) {
        if (element["status"] != "filled") {
          element.update("status", (value) => "available");
          element.update("isSelected", (value) => false);
        }
      });
    });
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
      seat.update("status", (value) => "available");
      seat.update("isSelected", (value) => false);
      selectedSeats.remove(seat["id"] as String);
    } else if (seat["status"] == "available" && selectedSeats.length < 4) {
      // Select the seat if it's available and not already selected
      seat.update("status", (value) => "selected");
      seat.update("isSelected", (value) => true);
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
        seat.update("status", (value) => "reserved");
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
