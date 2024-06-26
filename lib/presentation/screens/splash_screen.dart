import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/reservation_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ReservationController reservationController =
      Get.find<ReservationController>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulate a delay
    await Future.delayed(Duration(seconds: 3));

    // Check if the user is logged in by retrieving the token
    String? token = await UserManager.getToken();

    // Navigate to the appropriate screen
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/landing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Add your image here
          Center(
            child: Image.asset(
              'assets/images/reservasi-icon-text.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
