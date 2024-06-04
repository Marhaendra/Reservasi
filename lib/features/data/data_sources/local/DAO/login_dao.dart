import 'package:floor/floor.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'dart:async';

@dao
abstract class LoginDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLogin(LoginModel loginModel);

  @Query('SELECT * FROM LoginModel')
  Future<List<LoginModel>> getUserData();

  @Query('SELECT * FROM LoginModel WHERE token = :token')
  Future<LoginModel?> findLoginByToken(String token);
}
