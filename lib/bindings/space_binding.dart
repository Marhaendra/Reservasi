import 'package:get/get.dart';
import 'package:reservasi/controllers/space_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpaceController>(() => SpaceController());
  }
}
