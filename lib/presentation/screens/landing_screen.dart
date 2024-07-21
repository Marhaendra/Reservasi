import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservasi/presentation/screens/login_screen.dart';
import 'package:reservasi/presentation/screens/register_screen.dart';
import 'package:reservasi/theme.dart';
import '../controllers/login_controller.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_greetings()],
          ),
          Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              _landingImage(),
              const SizedBox(
                height: 32,
              ),
              _signIn(context),
              const SizedBox(
                height: 12,
              ),
              _signInGoogle(context),
              const SizedBox(
                height: 24,
              ),
              _signUp(context),
            ],
          ),
        ])));
  }

  RichText _signUp(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Belum punya akun? ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0.14,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 4.0), // Adjust the left padding as needed
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // Navigate to the login screen using the provided context
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: const Text(
                    'Buat Akun',
                    style: TextStyle(
                      color: Color(0xFF6497F5),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.17,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _signInGoogle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LoginController loginController = Get.put(LoginController());
        loginController.signInGoogle();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 44,
        decoration: BoxDecoration(
          color: MyTheme.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: MyTheme.primary.withOpacity(0.1), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Text(
              'Masuk dengan Google',
              style: GoogleFonts.poppins(fontSize: 14, color: MyTheme.black),
            ),
          ],
        ),
      ),
    );
  }

  Padding _signIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: MyTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Masuk',
                  style: GoogleFonts.poppins(fontSize: 14, color: primary),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }

  Padding _greetings() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          RichText(
            text: TextSpan(
              text: 'Jangan takut',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6497F5),
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: ' ga kebagian\ntempat duduk.',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF121212),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: '\nReservasi',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6497F5),
                height: 1,
              ),
              children: [
                TextSpan(
                  text: ' sekarang juga!',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF121212),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image _landingImage() => Image.asset("assets/images/splash.png");
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LandingScreen(),
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
    },
  ));
}
