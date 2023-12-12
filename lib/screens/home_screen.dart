import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/screens/order_screen.dart';
import 'package:reservasi/screens/profile_screen.dart';
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
                _header(context),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 126),
      child: Column(
        children: [
          searchBox(),
          const SizedBox(
            height: 16,
          ),
          SessionCard(title: 'Lab. Techno', time: '24 Desember')
        ],
      ),
    );
  }

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
            },
            child: Container(
              width: double.maxFinite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10.5),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "Cari",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.blue,
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
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              PhosphorIcon(
                iconData, // Use the provided IconData
                color: Colors.black,
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
                  color: Colors.black,
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
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Reservasi',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderScreen()),
                      );
                    },
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.ticket,
                      color: Colors.white,
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
                      color: Colors.white,
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

class SessionCard extends StatelessWidget {
  final String title;
  final String time;

  SessionCard({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4), // Adjust the padding as needed
                child: buildNumberContainer(index + 1),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              buildLegend('Kosong', Color(0xFDFDFDFD)),
              SizedBox(width: 8),
              buildLegend('Terisi', Color(0xBF8A8A8A)),
              SizedBox(width: 8),
              buildLegend('Dipilih', Color(0xFD6497F5)),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Pesan',
                style: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumberContainer(int number) {
    return Container(
      width: 20,
      height: 20,
      decoration: ShapeDecoration(
        color: (number == 4) ? Color(0xFF6497F5) : Color(0xFDFDFDFD),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: (number == 4) ? Color(0xFF6497F5) : Colors.black,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: (number == 4) ? Colors.white : Colors.black,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget buildLegend(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  color: (color == Color(0xFF6497F5))
                      ? Color(0xFF6497F5)
                      : Colors.black,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SessionCard(
              title: 'Lab. Techno',
              time: '24 Desember 2023',
            ),
          ),
        ),
      ),
    ),
  );
}
