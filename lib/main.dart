import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/presentation/screens/splash_screen.dart';
import 'package:reservasi/presentation/widgets/binding.dart';
import 'package:reservasi/presentation/screens/editProfile_screen.dart';
import 'package:reservasi/presentation/screens/help_screen.dart';
import 'package:reservasi/presentation/screens/home_screen.dart';
import 'package:reservasi/presentation/screens/landing_screen.dart';
import 'package:reservasi/presentation/screens/login_screen.dart';
import 'package:reservasi/presentation/screens/order_screen.dart';
import 'package:reservasi/presentation/screens/profile_screen.dart';
import 'package:reservasi/presentation/screens/register_screen.dart';
import 'package:reservasi/presentation/screens/reservation_screen.dart';
import 'package:reservasi/presentation/screens/search_screen.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await deleteDatabaseFile();
  // Initialize AppDatabase using Get.putAsync
  await Get.putAsync<AppDatabase>(() async {
    return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  });

  runApp(const MyApp());
}

// Future<void> deleteDatabaseFile() async {
//   final databasesPath = await getDatabasesPath();
//   final path = join(databasesPath, 'app_database.db');

//   // Delete the database
//   await deleteDatabase(path);
// }

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
