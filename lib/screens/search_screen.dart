import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reservasi/bindings/location_binding.dart';
import 'package:reservasi/controllers/location_controller.dart';
import 'package:reservasi/controllers/space_controller.dart';
import 'package:reservasi/models/location_model.dart';
import 'package:reservasi/models/space_model.dart';
import 'package:reservasi/screens/home_screen.dart';
import 'package:reservasi/theme.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final bool showLocations;

  SearchScreen({required this.showLocations});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late LocationController _locationController;
  late SpaceController _spaceController;

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
    _spaceController = Get.find<SpaceController>();
  }

  List<LocationModel> location = [];
  List<SpacesModel> space = [];

  void _getInitialInfo() {
    location = LocationModel.getLocation();
    space = SpacesModel.getSpaces();
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: ListView.builder(
          itemCount: space.length,
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
                    GestureDetector(
                      onTap: () {
                        String selectedSpaceName = space[index].name;
                        _spaceController.updateSpace(selectedSpaceName);
                        Get.to(() => HomeScreen(), binding: AppBindings());
                      },
                      child: Text(
                        space[index].name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyTheme.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (index < space.length - 1)
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
      margin: const EdgeInsets.symmetric(vertical: 4),
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
                    GestureDetector(
                      onTap: () {
                        String selectedLocationName = location[index].name;
                        _locationController
                            .updateLocation(selectedLocationName);
                        Get.to(() => HomeScreen(), binding: AppBindings());
                      },
                      child: Text(
                        location[index].name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyTheme.black,
                        ),
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
      width: double.infinity,
      height: 55,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 44,
              margin: const EdgeInsets.only(
                left: 16,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.primary.withOpacity(0.1),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyTheme.primary.withOpacity(0.1),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    color: MyTheme.primary,
                    fontSize: 14,
                  ),
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
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: On search tap
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Container(
              height: 44, // Set the height to match the TextField height
              width: 32,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Icon(
                  PhosphorIconsRegular.x,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
