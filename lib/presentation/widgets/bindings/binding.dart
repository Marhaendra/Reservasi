import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/login_dao.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/presentation/controllers/calendar_controller.dart';
import 'package:reservasi/presentation/controllers/location_controller.dart';
import 'package:reservasi/presentation/controllers/register_controller.dart';
import 'package:reservasi/presentation/controllers/reservation_controller.dart';
import 'package:reservasi/presentation/controllers/rooms_seats_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize ApiService and put it into GetX
    Get.lazyPut<ApiService>(() => ApiService(Dio()));

    // Register AppDatabase
    Get.putAsync<AppDatabase>(() => AppDatabase.getDatabase());

    // Initialize LoginDao
    Get.lazyPut<LoginDao>(() {
      final database = Get.find<AppDatabase>();
      return database.loginDao;
    });

    // Initialize controllers and put them into GetX
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<ReservationController>(
        () => ReservationController(Get.find<AppDatabase>()));
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<LocationController>(() => LocationController());

    // Initialize the AppDatabase asynchronously
    Get.putAsync<AppDatabase>(() async => await AppDatabase.getDatabase());

    // Initialize RoomsSeatsController with ApiService and AppDatabase
    Get.lazyPut<RoomsSeatsController>(() =>
        RoomsSeatsController(Get.find<ApiService>(), Get.find<AppDatabase>()));
  }
}
