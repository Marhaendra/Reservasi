import 'package:get/get.dart';
import 'package:reservasi/controllers/location_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
