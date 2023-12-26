import 'package:get/get.dart';

class SpaceController extends GetxController {
  RxString selectedSpace = "Ruang".obs;

  void updateSpace(String spaceName) {
    selectedSpace.value = spaceName;
    update();
  }

  void reset() {
    selectedSpace.value = "Ruang";
    update();
  }
}
