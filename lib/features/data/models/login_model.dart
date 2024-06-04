import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@entity
@JsonSerializable()
class LoginModel {
  @PrimaryKey()
  final String? token;
  final String? id;
  final String? role;
  final String? nama;

  LoginModel({
    required this.token,
    required this.id,
    required this.role,
    required this.nama,
  });

  factory LoginModel.fromJson(Map<String, dynamic> map) =>
      _$LoginModelFromJson(map);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
