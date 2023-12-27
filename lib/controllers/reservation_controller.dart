import 'package:get/get.dart';

class ReservationController extends GetxController {
  var indexSession = 0.obs;
  var selectedSeats = <String>[].obs; // List to store selected seat IDs

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

  bool isSeatSelected() {
    return selectedSeats.isNotEmpty;
  }

  var session = List.generate(
    4,
    (indexSession) => List<Map<String, dynamic>>.generate(
      75,
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
