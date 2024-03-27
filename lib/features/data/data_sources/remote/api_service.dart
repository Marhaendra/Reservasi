import 'package:reservasi/core/constants/constants.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/features/data/models/register_model.dart';
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
}
