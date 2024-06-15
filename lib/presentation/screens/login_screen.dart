import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/presentation/controllers/login_controller.dart';
import 'package:reservasi/presentation/screens/home_screen.dart';
import 'package:reservasi/theme.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();

  LoginScreen({super.key});

  void updatePassword(String password) {
    // Update the password value directly
    _passwordText.text = password;
  }

  void refreshHomeScreen() {
    print("Home screen refreshed");
  }

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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                _email(),
                const SizedBox(
                  height: 16,
                ),
                PasswordField(updatePassword, _passwordText),
                const SizedBox(
                  height: 32,
                ),
                _signIn(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _signIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              LoginController loginController = Get.put(LoginController());

              // Get the values entered in the text fields
              String email = _emailText.text;
              String password = _passwordText.text;

              // Call postRegister method from the controller with the input values
              loginController.postLogin(email: email, password: password);

              // Navigate to homescreen

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(refreshCallback: refreshHomeScreen),
                ),
              );
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF6497F5).withOpacity(0.1),
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
        ],
      ),
    );
  }

  Widget _email() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: _emailText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "example@mail.com",
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8A8A8A),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final Function(String) onUpdatePassword;
  final TextEditingController passwordText;

  PasswordField(this.onUpdatePassword, this.passwordText);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: widget.passwordText, // Use the provided controller
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Buat kata sandi",
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8A8A8A),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: PhosphorIcon(
              _obscureText
                  ? PhosphorIconsRegular.eye
                  : PhosphorIconsRegular.eyeSlash,
              color: const Color(0XFF8A8A8A),
            ),
          ),
        ),
        onChanged: (value) {
          widget.onUpdatePassword(value);
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
