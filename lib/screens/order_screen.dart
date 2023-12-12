import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/theme.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key});

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
      padding: const EdgeInsets.only(right: 16, left: 16, top: 126),
      child: Column(
        children: [orderCard(), history()],
      ),
    );
  }

  Container history() {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Riwayat",
                style: GoogleFonts.poppins(
                    color: black, fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lab. Techno",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "24 Desember",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Divider
                const Divider(
                  color: Colors.grey, // Choose your divider color
                  thickness: 0.5, // Set the thickness of the divider
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sesi 1",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: black,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "08.00-11.00",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: gray,
                            ),
                          ),
                        ],
                      ),
                      // Additional content here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumberContainer(String number) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, top: 8, bottom: 20),
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container orderCard() {
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
          Row(
            children: [
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lab. Techno",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: black),
                  ),
                  Text(
                    "24 Desember",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: gray,
                    ),
                  ),
                ],
              )),
              const Spacer(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sesi 1",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "08.00-11.00",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: gray,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              buildNumberContainer('4'),
              buildNumberContainer('4'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.5),
                    decoration: BoxDecoration(
                      color: red.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: red,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    width:
                        8), // Adds a flexible space between the two containers
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.5),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Check In",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                    'Pesanan',
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
