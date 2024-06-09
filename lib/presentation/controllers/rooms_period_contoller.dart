import 'package:get/get.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/rooms_period_dao.dart';
import 'package:reservasi/features/data/data_sources/local/app_database.dart';
import 'package:reservasi/features/data/data_sources/remote/api_service.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/helper/user_manager.dart';
import 'package:reservasi/presentation/controllers/rooms_seats_controller.dart';

class RoomsPeriodController extends GetxController {
  RxInt periodLength = 0.obs;
  RxList<RoomsPeriodModel> periodRooms = <RoomsPeriodModel>[].obs;

  final ApiService _apiService;
  final AppDatabase _appDatabase;

  RoomsPeriodController(this._apiService, this._appDatabase);

  @override
  void onInit() {
    super.onInit();
  }
}
