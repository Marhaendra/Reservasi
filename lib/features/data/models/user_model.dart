import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required int user_id,
    required String nama,
    required String email,
    required String no_telepon,
    required String tanggal_daftar,
    required String role,
    required String status,
    String? waktu_pemblokiran, // Made nullable
  }) : super(
            user_id: user_id,
            nama: nama,
            email: email,
            no_telepon: no_telepon,
            tanggal_daftar: tanggal_daftar,
            role: role,
            status: status,
            waktu_pemblokiran: waktu_pemblokiran);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserResponse {
  final String message;
  final List<UserModel> data;

  UserResponse({
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
