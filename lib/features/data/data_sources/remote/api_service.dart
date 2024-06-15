import 'package:reservasi/core/constants/constants.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/features/data/models/register_model.dart';
import 'package:reservasi/features/data/models/reservation_check_model.dart';
import 'package:reservasi/features/data/models/reservation_get_model.dart';
import 'package:reservasi/features/data/models/reservation_post_model.dart';
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

  @GET('/kursi/reserved')
  Future<SeatsResponse> getReservedKursi(
    @Header("Authorization") String token,
    @Query('tanggal_reservasi') String tanggalReservasi,
    @Query('ruangan_id') int ruanganId,
    @Query('periode_id') int periodeId,
  );

  @GET('/ruangan-periode')
  Future<RoomsPeriodResponse> getRuanganPeriode(
    @Header("Authorization") String token,
  );

  @GET('/reservasi')
  Future<ReservationGetResponse> getReservasi(
    @Header("Authorization") String token,
  );

  @GET('/reservasi/{id}')
  Future<ReservationGetResponse> getReservasiById(
    @Header("Authorization") String token,
    @Path('id') int id,
  );

  @POST('/reservasi')
  Future<ReservationPostModel> reservasi(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body,
      {required options});

  @PATCH('/reservasi/{id}')
  Future<ReservationCheckResponse> cancel(
    @Header("Authorization") String token,
    @Path('id') int id,
  );

  @PATCH('/reservasi/checkin/{id}')
  Future<ReservationCheckResponse> checkIn(
    @Header("Authorization") String token,
    @Path('id') int id,
  );

  @PATCH('/reservasi/checkout/{id}')
  Future<ReservationCheckResponse> checkOut(
    @Header("Authorization") String token,
    @Path('id') int id,
  );
}
