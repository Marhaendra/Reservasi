import 'package:flutter/material.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
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

  // await deleteDatabaseAndRecreate();

  // await Get.putAsync<AppDatabase>(() async {
  //   return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // });

  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .addMigrations([AppDatabase.migration3to4]).addMigrations([
    AppDatabase.migration4to5
  ]).addMigrations([AppDatabase.migration5to6]).addMigrations([
    AppDatabase.migration6to7
  ]).addMigrations([AppDatabase.migration7to8]).addMigrations(
          [AppDatabase.migration8to9]).build();

  Get.put(database);
  // Make the database instance available to GetX

  runApp(const MyApp());
}

// Future<void> deleteDatabaseAndRecreate() async {
//   // Close the existing database connection if any
//   await AppDatabase.closed();

//   // Get the path to the database file
//   final directory = await getApplicationDocumentsDirectory();
//   final dbPath = join(directory.path, 'app_database.db');

//   // Delete the existing database file if it exists
//   await deleteDatabase(dbPath);
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
        future: initializeDatabase(),
        builder: (context, snapshot) {
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
              '/eprofile': (context) => const EditProfileScreen(),
              '/help': (context) => const HelpScreen(),
              '/search': (context) => SearchScreen(
                    showLocations: true,
                  ),
              '/reservation': (context) => ReservationScreen(),
            },
          );
        });
  }

  Future<AppDatabase> initializeDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  }
}
