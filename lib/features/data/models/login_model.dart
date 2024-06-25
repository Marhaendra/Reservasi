import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends LoginEntity {
  LoginModel({
    required int id,
    required String role,
    required String name,
  }) : super(id: id, role: role, name: name);

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => super.props;
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final LoginModel userData;

  LoginResponse({
    required this.token,
    required this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginGoogleResponse {
  final LoginModel data;
  final String token;

  LoginGoogleResponse({
    required this.data,
    required this.token,
  });

  factory LoginGoogleResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginGoogleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginGoogleResponseToJson(this);
}
