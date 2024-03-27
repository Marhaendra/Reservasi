import 'package:get/get.dart';

class LocationController extends GetxController {
  var selectedLocation = "Lokasi".obs;

  void updateLocation(String locationName) {
    selectedLocation.value = locationName;
    update();
  }

  void reset() {
    selectedLocation.value = "Lokasi";
    update();
  }
}
