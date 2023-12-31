import 'package:flutter/material.dart';
import 'package:reservasi/bindings/location_binding.dart';
import 'package:reservasi/screens/editProfile_screen.dart';
import 'package:reservasi/screens/help_screen.dart';
import 'package:reservasi/screens/home_screen.dart';
import 'package:reservasi/screens/landing_screen.dart';
import 'package:reservasi/screens/login_screen.dart';
import 'package:reservasi/screens/order_screen.dart';
import 'package:reservasi/screens/profile_screen.dart';
import 'package:reservasi/screens/register_screen.dart';
import 'package:reservasi/screens/reservation_screen.dart';
import 'package:reservasi/screens/search_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: 'Reservasi',
      theme: ThemeData(
          // Your theme configurations here
          // ...
          ),
      home: HomeScreen(),
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/order': (context) => const OrderScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/eprofile': (context) => const EditProfileScreen(),
        '/help': (context) => const HelpScreen(),
        '/search': (context) => SearchScreen(
              showLocations: true,
            ),
        '/reservation': (context) => ReservationScreen(
              onReservationMade: () {},
            ),
      },
    );
  }
}
