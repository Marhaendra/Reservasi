import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/screens/editProfile_screen.dart';
import 'package:reservasi/screens/help_screen.dart';
import 'package:reservasi/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

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
      padding: const EdgeInsets.only(right: 16, left: 16, top: 126),
      child: Column(
        children: [
          profileButton(context),
        ],
      ),
    );
  }

  Container profileButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'User1234',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
              // Logic for the button tap
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFFDFDFD),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ]),
              child: Center(
                child: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFFDFDFD),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ]),
              child: Center(
                child: Text(
                  'Bantuan',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              // Logic for the button tap
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Keluar',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: red, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
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
      padding: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Icon and text tapped");
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const PhosphorIcon(
                    PhosphorIconsRegular.caretLeft,
                    color: Colors.white,
                  ),
                  Text(
                    'Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
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
