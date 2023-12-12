import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservasi/screens/login_screen.dart';
import 'package:reservasi/screens/register_screen.dart';
import 'package:reservasi/theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
              _signUp(context),
              const SizedBox(
                height: 12,
              ),
              _signInGoogle(),
              const SizedBox(
                height: 24,
              ),
              _signIn(context),
            ],
          ),
        ])));
  }

  RichText _signIn(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Sudah punya akun? ',
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
                          builder: (context) => const LoginScreen()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: const Text(
                    'Masuk',
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

  SizedBox _signInGoogle() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              // logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0XFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const SizedBox(
              height: 24,
              width: 24,
              child: Center(
                child: Text(''),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Image.asset(
                "assets/images/google.png",
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _signUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF6497F5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Buat Akun',
                  style: GoogleFonts.poppins(fontSize: 14, color: primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 324,
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 132,
                  height: 0.50,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                const SizedBox(width: 8),
                Text(
                  'ATAU',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 132,
                  height: 0.50,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
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
