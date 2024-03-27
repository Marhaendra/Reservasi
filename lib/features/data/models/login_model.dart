import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String id;
  String nama;
  String email;
  String password;
  String token;

  LoginModel(
      {required this.id,
      required this.nama,
      required this.email,
      required this.password,
      required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
