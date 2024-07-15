import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/features/data/models/reservation_get_model.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';
import 'package:reservasi/presentation/controllers/location_controller.dart';
import 'package:reservasi/presentation/controllers/login_controller.dart';
import 'package:reservasi/presentation/controllers/reservation_controller.dart';
import 'package:reservasi/presentation/controllers/rooms_period_contoller.dart';
import 'package:reservasi/presentation/controllers/rooms_seats_controller.dart';
import 'package:reservasi/presentation/screens/history_screen.dart';
import 'package:reservasi/presentation/screens/profile_screen.dart';
import 'package:reservasi/presentation/screens/reservation_screen.dart';
import 'package:reservasi/presentation/screens/search_screen.dart';
import 'package:reservasi/theme.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RoomsSeatsController roomsController = Get.find<RoomsSeatsController>();
  LocationController locationController = Get.find<LocationController>();
  CalendarController calendarController = Get.find<CalendarController>();
  ReservationController reservationController =
      Get.find<ReservationController>();
  RoomsPeriodController roomsPeriodController =
      Get.find<RoomsPeriodController>();

  LoginController loginController = Get.put(LoginController());

  final GlobalKey _tableCalendarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loginController.getUserData();
    reservationController.getReservasiById();
  }

  Widget _getReserved() {
    return Obx(() {
      if (reservationController.reservationById.isEmpty) {
        return orderCardBlank();
      } else {
        return orderedList();
      }
    });
  }

  void refreshReserved() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _tableCalendarKey;
    return Scaffold(
      appBar: AppBar(
        title: _header(context),
        backgroundColor: MyTheme.primary,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Use a Stack to overlay the text on top of the image
            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 636 / 2,
                  top: -49,
                  child: Container(
                    width: 636,
                    height: 261,
                    decoration: const ShapeDecoration(
                      color: MyTheme.primary,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                main(context, roomsController, locationController),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget main(BuildContext context, RoomsSeatsController roomsController,
      LocationController locationController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 38,
          ),
          searchBox(context, locationController, roomsController),
          const SizedBox(
            height: 24,
          ),
          _getReserved(),
        ],
      ),
    );
  }

  Widget orderedList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(maxHeight: 345),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pesananmu hari ini",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: MyTheme.primary,
              backgroundColor: MyTheme.white1,
              onRefresh: () async {
                await reservationController.getReservasiById();
              },
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount:
                        reservationController.todayReservationById.length,
                    itemBuilder: (context, index) {
                      ReservationGetModel reservation =
                          reservationController.todayReservationById[index];
                      return orderCard(reservation);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container orderCardBlank() {
    return Container(
      child: Container(
        height: 160,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: white,
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Color(0x19000000),
        //         blurRadius: 10,
        //         offset: Offset(0, 0),
        //         spreadRadius: 0,
        //       )
        //     ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Text("Kamu belum melakukan reservasi hari ini",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: MyTheme.black1)),
            ),
            // Padding(
            //   padding: EdgeInsets.zero,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {},
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 10.5),
            //             decoration: BoxDecoration(
            //               color: primary.withOpacity(.1),
            //               borderRadius: BorderRadius.circular(6),
            //             ),
            //             child: Center(
            //               child: Text(
            //                 "Pesan Sekarang",
            //                 style: GoogleFonts.poppins(
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 12,
            //                   color: primary,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget orderCard(ReservationGetModel reservation) {
    bool isCheckedIn = reservation.waktu_checkin != null;
    bool isCheckedOut = reservation.waktu_checkout != null;

    DateTime startTime = DateFormat('HH:mm').parse(reservation.jam_mulai);
    DateTime oneHourBeforeStartTime = startTime.subtract(Duration(hours: 1));
    DateTime currentTime = DateTime.now();
    bool isDisabled = currentTime.isBefore(oneHourBeforeStartTime);

    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reservation.nama_ruangan,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM').format(
                      DateFormat('dd/MM/yyyy')
                          .parse(reservation.tanggal_reservasi),
                    ),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.nama_periode,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${reservation.jam_mulai.substring(0, 5)} - ${reservation.jam_selesai.substring(0, 5)}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            children: generateContainersWithPadding(
                [reservation.nomor_kursi.toString()], 8),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: isCheckedIn
                      ? null
                      : () async {
                          await reservationController
                              .cancelReservation(reservation.reservasi_id);
                          await reservationController.getReservasiById();
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.5),
                    decoration: BoxDecoration(
                      color: isCheckedIn
                          ? Colors.grey.withOpacity(.1)
                          : Colors.red.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: isCheckedIn ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: isCheckedOut || isDisabled
                      ? null
                      : () async {
                          if (isCheckedIn) {
                            await reservationController
                                .checkOut(reservation.reservasi_id);
                            await reservationController.getReservasiById();
                          } else {
                            await reservationController
                                .checkIn(reservation.reservasi_id);
                            await reservationController.getReservasiById();
                          }
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.5),
                    decoration: BoxDecoration(
                      color: isCheckedOut || isDisabled
                          ? Colors.grey.withOpacity(.1)
                          : isCheckedIn
                              ? Colors.red.withOpacity(.1)
                              : Colors.blue.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        isCheckedOut
                            ? "Checked Out"
                            : isCheckedIn
                                ? "Check Out"
                                : "Check In",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: isCheckedOut
                              ? Colors.grey
                              : isCheckedIn
                                  ? Colors.red
                                  : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx searchBox(BuildContext context, LocationController locationController,
      RoomsSeatsController roomsController) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyTheme.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            inputSearchBox(
                placeholder: "Lokasi",
                iconData: PhosphorIconsRegular.mapPin,
                value: locationController.selectedLocation.value,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        showLocations: true,
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 16,
            ),
            inputSearchBox(
              placeholder: "Tanggal",
              iconData: PhosphorIconsRegular.calendar,
              value: calendarController.dateFormat
                  .format(calendarController.focusedDay)
                  .toString(),
              onTap: () async {
                var result = await showModalBottomSheet<Map<String, DateTime?>>(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        Container(
                          child: TableCalendar(
                            headerStyle:
                                HeaderStyle(formatButtonVisible: false),
                            availableGestures: AvailableGestures.all,
                            focusedDay: calendarController.focusedDay,
                            firstDay: DateTime.now(),
                            lastDay: calendarController.lastDay,
                            selectedDayPredicate: (selectedDay) => isSameDay(
                                selectedDay, calendarController.focusedDay),
                            calendarFormat: calendarController.calendarFormat,
                            onDaySelected: (selectedDay, focusedDay) {
                              calendarController.daySelect(
                                  selectedDay, focusedDay);
                              calendarController.animateToDay(selectedDay);
                              calendarController.refreshCalendar();
                              calendarController.updateSelectedDay(selectedDay);
                              calendarController.dateList();
                              Navigator.of(context).pop({
                                'selectedDay': selectedDay,
                                'focusedDay': focusedDay
                              });
                            },
                            calendarStyle: CalendarStyle(
                              selectedDecoration: const BoxDecoration(
                                color: MyTheme.primary,
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: MyTheme.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (result != null && result['focusedDay'] != null) {
                  calendarController.daySelect(
                      result['selectedDay']!, result['focusedDay']!);
                }
                setState(() {});
              },
            ),
            const SizedBox(
              height: 16,
            ),
            inputSearchBox(
                placeholder: "Ruang",
                iconData: PhosphorIconsRegular.couch,
                value: roomsController.selectedRoom.value,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              showLocations: false,
                            )),
                  );
                }),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                if (locationController.selectedLocation.value == "Lokasi" ||
                    roomsController.selectedRoom.value == "Ruang") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Silakan pilih Lokasi dan Ruang sebelum melakukan pencarian.',
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: MyTheme.white),
                    ),
                    duration: const Duration(milliseconds: 2500),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: MyTheme.red,
                  ));
                } else {
                  loginController.getUserData();
                  if (loginController.userData.isNotEmpty) {
                    String? waktu_pemblokiran =
                        loginController.userData.first.waktu_pemblokiran;
                    final status = await UserManager.getStatus();
                    print('status: $status');

                    if (status == 'nonaktif') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: MyTheme.white,
                            title: Text(
                              'Akun Nonaktif',
                              style: TextStyle(
                                  color: MyTheme.black, fontFamily: 'poppin'),
                            ),
                            content: Text(
                              'Anda tidak dapat melakukan reservasi sampai $waktu_pemblokiran.',
                              style: TextStyle(
                                  color: MyTheme.black, fontFamily: 'poppin'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK',
                                    style: TextStyle(
                                        color: MyTheme.red,
                                        fontFamily: 'poppin')),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Get.dialog(
                        Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );

                      roomsController.fetchCombinedRooms();
                      roomsPeriodController.fetchRoomsPeriod();
                      reservationController.missedSession();
                      reservationController.fetchAvailableKursi();
                      await reservationController.initializeSession();

                      Get.back();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationScreen(),
                        ),
                      );
                    }
                  } else {
                    // Handle case when userData is empty if needed
                  }
                }
              },
              child: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10.5),
                decoration: BoxDecoration(
                  color: MyTheme.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Pesan",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyTheme.primary,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget inputSearchBox({
    required String placeholder,
    required IconData iconData,
    required String value,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeholder,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: MyTheme.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              PhosphorIcon(
                iconData,
                color: MyTheme.black,
                size: 18,
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: MyTheme.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30), // Adjust the top padding
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              'Reservasi',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: MyTheme.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                // Padding for the Ticket icon
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                    },
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.ticket,
                      color: MyTheme.white,
                      size: 32,
                    ),
                  ),
                ),
                // Padding for the User icon
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.user,
                      color: MyTheme.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomColoredContainer extends StatelessWidget {
  final String text;
  final Color color;

  const CustomColoredContainer({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: MyTheme.white, // You can use MyTheme.white if needed
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

List<Widget> generateContainersWithPadding(List<String> texts, double padding) {
  List<Widget> containers = [];
  for (int i = 0; i < texts.length; i++) {
    containers.add(CustomColoredContainer(
      text: texts[i],
      color: MyTheme.primary,
    ));
    if (i < texts.length - 1) {
      containers.add(SizedBox(width: padding));
    }
  }
  return containers;
}
