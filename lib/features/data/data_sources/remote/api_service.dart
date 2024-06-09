import 'package:reservasi/core/constants/constants.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/features/data/models/register_model.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: apiBaseURL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/registerUser')
  Future<RegisterModel> register(@Body() Map<String, dynamic> body);

  @POST('/login')
  Future<LoginModel> login(@Body() Map<String, dynamic> body);

  @GET('/ruangan')
  Future<RoomsResponse> getRuangan(@Header("Authorization") String token);

  @GET('/kursi')
  Future<SeatsResponse> getKursi(@Header("Authorization") String token);

  @GET('/kursi/available')
  Future<SeatsResponse> getAvailableKursi(
    @Header("Authorization") String token,
    @Query('tanggal_reservasi') String tanggalReservasi,
    @Query('ruangan_id') int ruanganId,
    @Query('periode_id') int periodeId,
  );

  @GET('/ruangan-periode')
  Future<RoomsPeriodResponse> getRuanganPeriode(
    @Header("Authorization") String token,
  );
}
