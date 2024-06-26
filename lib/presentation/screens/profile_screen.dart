import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/login_controller.dart';
import 'package:reservasi/presentation/controllers/profile_controller.dart';
import 'package:reservasi/presentation/screens/editProfile_screen.dart';
import 'package:reservasi/presentation/screens/help_screen.dart';
import 'package:reservasi/presentation/screens/history_screen.dart';
import 'package:reservasi/presentation/screens/splash_screen.dart';
import 'package:reservasi/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    UserManager.initializeNama();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
      padding: const EdgeInsets.only(right: 16, left: 16, top: 70),
      child: Column(
        children: [
          profileButton(),
        ],
      ),
    );
  }

  Container profileButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Obx(() {
            // Fetch the first user's name if available
            String userNama = UserManager.nama.value;

            return Container(
              alignment: Alignment.center,
              child: Text(
                userNama,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: MyTheme.white,
                ),
              ),
            );
          }),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
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
                ],
              ),
              child: Center(
                child: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
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
                ],
              ),
              child: Center(
                child: Text(
                  'Bantuan',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final isGoogleSignIn = await UserManager.getIsGoogleSignIn();

              if (isGoogleSignIn == true) {
                // If user signed in with Google, sign out and clear preferences
                LoginController loginController = Get.put(LoginController());
                await loginController.signOutGoogle();
                await UserManager.clearUserManager();
              } else {
                // If not signed in with Google, just clear preferences
                await UserManager.clearUserManager();
              }

              // Navigate to SplashScreen and remove all routes from stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false,
              );
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
                    fontSize: 14,
                    color: red,
                    fontWeight: FontWeight.w500,
                  ),
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
                  'Profil',
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryScreen()),
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
