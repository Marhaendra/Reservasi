import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservasi/presentation/controllers/profile_controller.dart';
import 'package:reservasi/presentation/screens/profile_screen.dart';
import 'package:reservasi/theme.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController _namaText = TextEditingController();
  final TextEditingController _noTeleponText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _header(),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                _name(),
                const SizedBox(
                  height: 16,
                ),
                _noTelepon(),
                const SizedBox(
                  height: 32,
                ),
                _save(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'Edit Profil',
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  Padding _save(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              String nama = _namaText.text;
              String noTelepon = _noTeleponText.text;

              // Check if nama or noTelepon is empty
              if (nama.isEmpty || noTelepon.isEmpty) {
                // Show a snackbar indicating that fields cannot be empty
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Nama dan nomor telepon tidak boleh kosong.',
                    style:
                        GoogleFonts.poppins(fontSize: 10, color: MyTheme.white),
                  ),
                  duration: const Duration(milliseconds: 2500),
                  // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16 // Inner padding for SnackBar content.
                      ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: MyTheme.red,
                ));
              } else {
                // Get the profile controller instance
                ProfileController profileController =
                    Get.find<ProfileController>();

                // Post edit profile
                await profileController.postEditProfile(
                    nama: nama, no_telepon: noTelepon);

                // Navigate to ProfileScreen and pop current route
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                ).then((_) {
                  Navigator.pop(context);
                });
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF6497F5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(fontSize: 14, color: primary),
                ),
              ),
            ),
          ),
        ],
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
          hintText: "081234567890",
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
        controller: _namaText,
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
