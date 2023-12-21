import 'package:get/get.dart';

class ReservationController extends GetxController {
  var indexSession = 0.obs;
  var selectedSeats = <String>[].obs; // List to store selected seat IDs

  void reset() {
    session.forEach((element) {
      element.forEach((element) {
        if (element["status"] != "filled") {
          element.update("status", (value) => "available");
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
    if (session[indexSession.value][indexSeatSelected]["status"] ==
        "selected") {
      // Deselect the seat on double tap
      session[indexSession.value][indexSeatSelected]
          .update("status", (value) => "available");
      selectedSeats.remove(
          session[indexSession.value][indexSeatSelected]["id"] as String);
    } else if (session[indexSession.value][indexSeatSelected]["status"] ==
            "available" &&
        selectedSeats.length < 4) {
      // Select the seat if it's available and not already selected
      session[indexSession.value][indexSeatSelected]
          .update("status", (value) => "selected");
      selectedSeats
          .add(session[indexSession.value][indexSeatSelected]["id"] as String);
    }
    session.refresh();
    print(session[indexSession.value][indexSeatSelected]);
  }

  var session = List.generate(
    4,
    (indexSession) => List<Map<String, dynamic>>.generate(
      75,
      (indexSeat) {
        if (indexSession == 0) {
          // session ke 1
          if (indexSeat >= 24 && indexSeat <= 26 ||
              indexSeat >= 40 && indexSeat <= 44) {
            return {
              "id": "ID-${indexSession + 1}-${indexSeat + 1}",
              "status": "filled",
            };
          } else {
            return {
              "id": "ID-${indexSession + 1}-${indexSeat + 1}",
              "status": "available",
            };
          }
        } else if (indexSession == 1) {
          // session ke 2
          if (indexSeat >= 5 && indexSeat <= 35) {
            return {
              "id": "ID-${indexSession + 1}-${indexSeat + 1}",
              "status": "filled",
            };
          } else {
            return {
              "id": "ID-${indexSession + 1}-${indexSeat + 1}",
              "status": "available",
            };
          }
        } else {
          return {
            "id": "ID-${indexSession + 1}-${indexSeat + 1}",
            "status": "available",
          };
        }
      },
    ),
  ).obs;
}
