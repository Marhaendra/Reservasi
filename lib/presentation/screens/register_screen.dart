import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/presentation/controllers/register_controller.dart';
import 'package:reservasi/presentation/screens/landing_screen.dart';
import 'package:reservasi/presentation/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  // Declare controllers for other fields
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _noTeleponText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();

  void updatePassword(String password) {
    // Update the password value directly
    _passwordText.text = password;
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
                    'Daftar',
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
                  height: 12,
                ),
                _name(),
                const SizedBox(
                  height: 12,
                ),
                _email(),
                const SizedBox(
                  height: 12,
                ),
                _noTelepon(),
                const SizedBox(
                  height: 12,
                ),
                PasswordField(updatePassword, _passwordText),
                const SizedBox(
                  height: 16,
                ),
                _signUpButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          RegisterController registerController =
              Get.find<RegisterController>();

          // Get the values entered in the text fields
          String name = _nameText.text;
          String email = _emailText.text;
          String noTelepon = _noTeleponText.text;
          String password = _passwordText.text;

          // Call postRegister method from the controller with the input values
          registerController.postRegister(
            nama: name,
            email: email,
            no_telepon: noTelepon,
            password: password,
          );
        },
        child: Text('Buat Akun'),
      ),
    );
  }

  Widget _noTelepon() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
        controller: _noTeleponText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "08123456789",
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8A8A8A),
          ),
        ),
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
          borderRadius: BorderRadius.circular(6)),
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

  Widget _name() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
        controller: _nameText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Nama Lengkap",
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
    initialRoute: '/landing',
    routes: {
      '/': (context) => RegisterScreen(),
      '/login': (context) => LoginScreen(),
      '/landing': (context) => LandingScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterScreen(),
    );
  }
}
