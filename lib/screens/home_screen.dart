import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/screens/order_screen.dart';
import 'package:reservasi/screens/profile_screen.dart';
import 'package:reservasi/screens/reservation_screen.dart';
import 'package:reservasi/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Use a Stack to overlay the text on top of the image
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 261,
                  width: 636,
                  child: Image.asset(
                    "assets/images/bg.png",
                    fit: BoxFit.fill,
                  ),
                ),
                main(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget main(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          const SizedBox(
            height: 38,
          ),
          searchBox(context),
          const SizedBox(
            height: 20,
          ),
          lastBooked()
        ],
      ),
    );
  }

  Column lastBooked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terakhir dipesan',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w700, color: MyTheme.black),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
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
              ]),
          child: Column(children: [
            const Row(
              children: [
                Text('Lab. Techno',
                    style: TextStyle(
                      color: MyTheme.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    )),
                Spacer(),
                Text('10 Desember 2023',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A8A8A),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                const Row(
                  children: [
                    Text('Sesi 1',
                        style: TextStyle(
                          color: MyTheme.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('08.00 - 11.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8A8A8A),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: generateContainersWithPadding(['4', '6', '7'], 8),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                // TODO: On search tap
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
                    "Pesan lagi untuk hari ini",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyTheme.primary,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }

  Container searchBox(BuildContext context) {
    return Container(
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
          input(
            placeholder: "Lokasi",
            iconData: PhosphorIconsRegular.mapPin,
            value: "Jakarta",
          ),
          const SizedBox(
            height: 16,
          ),
          input(
            placeholder: "Tanggal",
            iconData: PhosphorIconsRegular.calendar,
            value: "19 September",
          ),
          const SizedBox(
            height: 16,
          ),
          input(
            placeholder: "Ruang",
            iconData: PhosphorIconsRegular.couch,
            value: "Lab. Techno",
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              // TODO: On search tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReservationScreen()),
              );
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
                  "Cari",
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
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: MyTheme.black,
                ),
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
      padding: const EdgeInsets.only(top: 60), // Adjust the top padding
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
                            builder: (context) => const OrderScreen()),
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
