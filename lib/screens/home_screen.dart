import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/screens/order_screen.dart';
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
        ],
      ),
    );
  }

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Column(
        children: [
          input(
              placeholder: "Lokasi",
              iconData: PhosphorIconsRegular.mapPin,
              value: "Jakarta"),
          const SizedBox(
            height: 16,
          ),
          input(
              placeholder: "Tanggal",
              iconData: PhosphorIconsRegular.calendar,
              value: "19 September"),
          const SizedBox(
            height: 16,
          ),
          input(
              placeholder: "Ruang",
              iconData: PhosphorIconsRegular.couch,
              value: "Lab. Techno"),
          const SizedBox(
            height: 16,
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
                  color: primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  "Cari",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: primary),
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
                fontWeight: FontWeight.w500, fontSize: 12, color: gray),
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
      padding: const EdgeInsets.only(
          top: 60), // Adjust the top padding to position the text
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
                      // Handle the tap action for the user icon
                      print("User icon tapped");
                      // Add your specific action here
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
