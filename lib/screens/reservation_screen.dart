import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/screens/order_screen.dart';
import 'package:reservasi/theme.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key});

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
        children: [_header(context)],
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60), // Adjust the top padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding for the Ticket icon
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderScreen()),
                );
              },
              child: const PhosphorIcon(
                PhosphorIconsRegular.caretLeft,
                color: MyTheme.white,
                size: 24,
              ),
            ),
          ),
          // Padding for the User icon
          Text(
            'Lab. Techno',
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: MyTheme.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
