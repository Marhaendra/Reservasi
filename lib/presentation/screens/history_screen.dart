import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/features/data/models/reservation_get_model.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';
import 'package:reservasi/presentation/controllers/history_controller.dart';
import 'package:reservasi/theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key});
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  HistoryController historyController = Get.find<HistoryController>();
  CalendarController calendarController = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();
    historyController.getAllReservasiById();
  }

  @override
  Widget build(BuildContext context) {
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
                main(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget main() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 47),
      child: Column(
        children: [
          FutureBuilder(
            future: historyController.getAllReservasiById(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  backgroundColor: MyTheme.primary.withOpacity(.1),
                  color: MyTheme.primary,
                ); // Show a loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return bookedHistoryList();
              }
            },
          ),
          // history()
        ],
      ),
    );
  }

  Widget bookedHistoryList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 650),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              color: MyTheme.primary,
              backgroundColor: MyTheme.white1,
              onRefresh: () async {
                historyController.allReservationById();
              },
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: historyController.allReservationById.length,
                    itemBuilder: (context, index) {
                      ReservationGetModel reservation =
                          historyController.allReservationById[index];
                      return bookedHistoryCard(reservation);
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

  Column bookedHistoryCard(ReservationGetModel reservation) {
    Color statusColor;

    // Set the color based on the reservation status
    switch (reservation.status) {
      case 'Aktif':
        statusColor = MyTheme.primary;
        break;
      case 'Dibatalkan':
        statusColor = MyTheme.red;
        break;
      case 'Absen':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = MyTheme.primary; // Default color
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    reservation.nama_ruangan,
                    style: const TextStyle(
                      color: MyTheme.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    reservation.tanggal_reservasi,
                    style: const TextStyle(
                      color: MyTheme.black1,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    reservation.nama_periode,
                    style: const TextStyle(
                      color: MyTheme.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${reservation.jam_mulai.substring(0, 5)} - ${reservation.jam_selesai.substring(0, 5)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF8A8A8A),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        reservation.status,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Row(
                children: generateContainersWithPadding(
                    [reservation.nomor_kursi.toString()], 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget input({
    required String placeholder,
    required IconData iconData,
    required String value,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeholder,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 12, color: gray),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              PhosphorIcon(
                iconData, // Use the provided IconData
                color: MyTheme.black,
                size: 18,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 12, color: black),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Icon and text tapped");
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsRegular.caretLeft,
                  color: MyTheme.white,
                ),
                Text(
                  'Riwayat',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: MyTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                // Padding for the Ticket icon
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Handle the tap action for the ticket icon
                      print("Ticket icon tapped");
                      // Add your specific action here
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
                      // Handle the tap action for the user icon
                      print("User icon tapped");
                      // Add your specific action here
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
