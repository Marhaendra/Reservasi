import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';
import 'package:reservasi/presentation/controllers/location_controller.dart';
import 'package:reservasi/presentation/controllers/register_controller.dart';
import 'package:reservasi/presentation/controllers/reservation_controller.dart';
import 'package:reservasi/presentation/controllers/space_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(Dio()));
    Get.lazyPut<RegisterController>(() => RegisterController());

    Get.lazyPut<ReservationController>(() => ReservationController());

    Get.lazyPut<CalendarController>(() => CalendarController());

    Get.lazyPut<LocationController>(() => LocationController());
    Get.lazyPut<SpaceController>(() => SpaceController());
  }
}
