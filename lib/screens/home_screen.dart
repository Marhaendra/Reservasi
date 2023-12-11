import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                _header(),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _header() {
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
                GestureDetector(
                  onTap: () {
                    // Handle the tap action for the ticket icon
                    print("Ticket icon tapped");
                    // Add your specific action here
                  },
                  child: const PhosphorIcon(
                    PhosphorIconsRegular.ticket,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
