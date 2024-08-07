import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/reservation_get_model.dart';
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
  RxList<ReservationGetModel> reservationById = <ReservationGetModel>[].obs;
  RxList<ReservationGetModel> todayReservationById =
      <ReservationGetModel>[].obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;
  final RoomsPeriodController roomsPeriodController =
      Get.find<RoomsPeriodController>();
  final RoomsSeatsController roomsSeatsController =
      Get.find<RoomsSeatsController>();

  var indexSession = 0.obs;
  var selectedSeats = <String>[].obs;
  var reservedSeat = <String>[].obs;
  var reservedDate = "".obs;
  var reservedSeatDate = <String>[].obs;
  var periodList = <int>[].obs;
  var reservation = <ReservationPostModel>[].obs;
  var todaySeatReservationById = <int>[].obs;
  var checkInToday = <String>[].obs;
  var checkOutToday = <String>[].obs;
  var cancelToday = <String>[].obs;
  RxList<int> missedSessionPeriod = <int>[].obs;

  final ApiService _apiService;

  ReservationController(this._apiService);

  List<int> existingNomorKursi = [];
  List<int> brokenNomorKursi = [];

  @override
  void onInit() {
    super.onInit();
    initializeSession();
  }

  Future<void> cancelReservation(List<int> reservasiIds) async {
    try {
      final token = await UserManager.getToken();

      for (int i = 0; i < reservasiIds.length; i++) {
        try {
          final response = await _apiService.cancel(token!, reservasiIds[i]);
          cancelToday.add(response.data.first as String);
        } catch (error) {
          print(error);
        }
      }
      print('All reservations canceled successfully!');
      print('cancelToday: $cancelToday');
    } catch (error) {
      print(error);
    }
  }

  Future<void> checkOut(List<int> reservasiIds) async {
    try {
      final token = await UserManager.getToken();

      for (int i = 0; i < reservasiIds.length; i++) {
        try {
          final response = await _apiService.checkOut(token!, reservasiIds[i]);
          checkOutToday.add(response.data.first as String);
        } catch (error) {
          print(error);
        }
      }
      print('All reservations checked out successfully!');
    } catch (error) {
      print(error);
    }
  }

  Future<void> checkIn(List<int> reservasiIds) async {
    try {
      final token = await UserManager.getToken();

      for (int i = 0; i < reservasiIds.length; i++) {
        try {
          final response = await _apiService.checkIn(token!, reservasiIds[i]);
          checkInToday.add(response.data.first as String);
        } catch (error) {
          print(error);
        }
      }
      print('All reservations checked in successfully!');
    } catch (error) {
      print(error);
    }
  }

  Future<void> getReservasiById() async {
    try {
      final token = await UserManager.getToken();
      final id = await UserManager.getUserId();

      if (token == null || id == null) {
        print('Token or ID is null');
        return;
      }

      // print('Token in getReservasiById: $token');
      // print('ID in getReservasiById: $id');

      ReservationGetResponse reservationGetResponse =
          await _apiService.getReservasiById(token, id);

      reservationById.value = reservationGetResponse.data
          .where((reservation) =>
              reservation.status == 'Aktif' &&
              reservation.waktu_checkout == null)
          .toList();

      DateTime todays = DateTime.now();
      String today = DateFormat('d/M/yyyy').format(todays);
      todayReservationById.value = reservationById
          .where(
              (todayReservation) => todayReservation.tanggal_reservasi == today)
          .toList();

      // Print the response to inspect it
      // print('Response from API: $reservationById');
      // print('todayReservation: $todayReservationById');
    } catch (error) {
      print('Error fetching reservations: $error');
    }
  }

  Future<void> missedSession() async {
    try {
      List<int> periodMissed =
          await roomsPeriodController.getMissedSessionPeriod();
      missedSessionPeriod.assignAll(periodMissed);
      print('missedSessionPeriod: $missedSessionPeriod');
    } catch (error) {
      print('Error in missedSession: $error');
    }
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

      await getReservasiById();

      bool reservationExists = reservationById.any((reservation) {
        String formattedReservationDate = DateFormat('yyyy-MM-dd').format(
            DateFormat('d/M/yyyy').parse(reservation.tanggal_reservasi));

        return formattedReservationDate == tanggalReservasi &&
            reservation.periode_id == periodeId &&
            reservation.ruangan_id != ruanganId;
      });

      if (reservationExists) {
        Get.snackbar(
          "Sudah Dipesan",
          "Kamu udah pesen buat tanggal dan waktu ini.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }

      // Make individual API calls for each kursi_id
      for (int i = 0; i < kursiIds.length; i++) {
        // Create a copy of body for this iteration
        Map<String, dynamic> body = {
          'user_id': userId,
          'nama': nama,
          'tanggal_reservasi': tanggalReservasi,
          'kursi_id': kursiIds[i],
          'ruangan_id': ruanganId,
          'nomor_kursi': nomorKursis[i],
          'periode_id': periodeId,
        };

        // Add debug prints to check the structure of the body object
        print('Sending reservation request with body: $body');

        // Make the API call
        try {
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
        } catch (error) {
          print(
              'Error in reservation request for kursi_id ${kursiIds[i]}: $error');
        }
      }

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

      brokenNomorKursi.clear();
      seats.forEach((seat) {
        if (seat.isBroken == 1) {
          brokenNomorKursi.add(seat.nomor_kursi);
        }
      });
      print('exKursi: $existingNomorKursi');
      print('brokenKursi: $brokenNomorKursi');
    } catch (error) {
      print('error reservationcontroller: $error');
    }
  }

  Future<void> initializeSession() async {
    await missedSession();
    await fetchAvailableKursi();
    var seat = roomsSeatsController.seatList;
    int seatLength = seat.length;
    int periodLength = periodList.length;

    generateSessionList(
        periodLength, seatLength, existingNomorKursi, brokenNomorKursi);
  }

  void generateSessionList(int periodLength, int seatLength,
      List<int> existingNomorKursi, List<int> brokenNomorKursi) {
    final CalendarController calendarController =
        Get.find<CalendarController>();
    DateTime selectedDay = calendarController.selectedDay.value;
    final isToday = DateTime.now();

    final selectedDayFormatted = DateFormat('yyyy-MM-dd').format(selectedDay);
    final isTodayFormatted = DateFormat('yyyy-MM-dd').format(isToday);
    print('selected: $selectedDayFormatted - isToday: $isTodayFormatted');

    session.value = List.generate(
      periodLength,
      (indexSession) => List<Map<String, dynamic>>.generate(
        seatLength,
        (indexSeat) {
          final seatNumber = indexSeat + 1;
          final isAvailable = existingNomorKursi.contains(seatNumber);
          final isBroken = brokenNomorKursi.contains(seatNumber);

          // Check if the session is missed for today
          final isMissedForToday =
              missedSessionPeriod.contains(periodList[indexSession]) &&
                  selectedDayFormatted == isTodayFormatted;

          String status;
          if (isMissedForToday) {
            status = "filled";
          } else if (isBroken) {
            status = "filled";
          } else if (isAvailable) {
            status = "available";
          } else {
            status = "filled";
          }

          return {
            "id": "ID-${indexSession + 1}-${seatNumber}",
            "status": status,
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

  Map<String, List<ReservationGetModel>> groupReservationsByRoomAndPeriod(
      List<ReservationGetModel> reservations) {
    Map<String, List<ReservationGetModel>> groupedReservations = {};

    for (var reservation in reservations) {
      String key = '${reservation.nama_ruangan}-${reservation.nama_periode}';
      if (groupedReservations.containsKey(key)) {
        groupedReservations[key]!.add(reservation);
      } else {
        groupedReservations[key] = [reservation];
      }
    }

    return groupedReservations;
  }

  Map<String, List<int>> extractReservasiIds(
      Map<String, List<ReservationGetModel>> groupedReservations) {
    Map<String, List<int>> reservasiIds = {};

    groupedReservations.forEach((key, reservations) {
      reservasiIds[key] = reservations.map((res) => res.reservasi_id).toList();
    });

    return reservasiIds;
  }
}
