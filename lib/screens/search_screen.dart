import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [_searchBar()],
      )),
    );
  }

  Container _searchBar() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: MyTheme.primary.withOpacity(0.1),
          ),
        ],
        borderRadius: BorderRadius.circular(12.0), // Set the border radius
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: MyTheme.primary.withOpacity(0.1),
          hintText: 'Search',
          hintStyle: GoogleFonts.poppins(color: MyTheme.primary, fontSize: 14),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              PhosphorIconsRegular.magnifyingGlass,
              color: MyTheme.primary,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(12.0), // Set the same border radius
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
