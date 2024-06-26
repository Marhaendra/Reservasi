import 'package:flutter/material.dart';
import 'package:reservasi/presentation/screens/history_screen.dart';
import 'package:reservasi/presentation/screens/splash_screen.dart';
import 'package:reservasi/presentation/widgets/bindings/binding.dart';
import 'package:reservasi/presentation/screens/editProfile_screen.dart';
import 'package:reservasi/presentation/screens/help_screen.dart';
import 'package:reservasi/presentation/screens/home_screen.dart';
import 'package:reservasi/presentation/screens/landing_screen.dart';
import 'package:reservasi/presentation/screens/login_screen.dart';
import 'package:reservasi/presentation/screens/profile_screen.dart';
import 'package:reservasi/presentation/screens/register_screen.dart';
import 'package:reservasi/presentation/screens/reservation_screen.dart';
import 'package:reservasi/presentation/screens/search_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      title: 'Reservasi',
      theme: ThemeData(
          // Your theme configurations here
          // ...
          ),
      home: SplashScreen(),
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
      routes: {
        '/landing': (context) => LandingScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/eprofile': (context) => EditProfileScreen(),
        '/help': (context) => const HelpScreen(),
        '/search': (context) => SearchScreen(
              showLocations: true,
            ),
        '/reservation': (context) => ReservationScreen(),
      },
    );
  }
}
