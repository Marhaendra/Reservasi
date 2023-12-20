import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/models/location_model.dart';
import 'package:reservasi/models/spaces_model.dart';
import 'package:reservasi/screens/home_screen.dart';
import 'package:reservasi/theme.dart';

class SearchScreen extends StatefulWidget {
  final bool showLocations;

  SearchScreen({required this.showLocations});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<LocationModel> location = [];
  List<SpacesModel> spaces = [];

  void _getInitialInfo() {
    location = LocationModel.getLocation();
    spaces = SpacesModel.getSpaces();
  }

  Widget _getListShow() {
    if (widget.showLocations) {
      return locationList(); // Return the widget directly
    } else {
      return spacesList(); // Return the widget directly
    }
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _searchBar(),
            Expanded(
              child: _getListShow(), // Use the returned widget
            ),
          ],
        ),
      ),
    );
  }

  Container spacesList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        width: double.infinity,
        height: 600,
        child: ListView.builder(
          itemCount: spaces.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spaces[index].name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MyTheme.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (index < spaces.length - 1)
                      const Divider(
                        color: MyTheme.grey1,
                        thickness: 1.0,
                        indent: 0,
                        endIndent: 0,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container locationList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        width: double.infinity,
        height: 600,
        child: ListView.builder(
          itemCount: location.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location[index].name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MyTheme.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (index < location.length - 1)
                      const Divider(
                        color: MyTheme.grey1,
                        thickness: 1.0,
                        indent: 0,
                        endIndent: 0,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
