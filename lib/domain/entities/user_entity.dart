import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final int user_id;
  final String nama;
  final String email;
  final String no_telepon;
  final String tanggal_daftar;
  final String role;
  final String status;
  final String? waktu_pemblokiran;

  const UserEntity({
    required this.user_id,
    required this.nama,
    required this.email,
    required this.no_telepon,
    required this.tanggal_daftar,
    required this.role,
    required this.status,
    required this.waktu_pemblokiran,
  });

  @override
  List<Object?> get props => [
        user_id,
        nama,
        email,
        no_telepon,
        tanggal_daftar,
        role,
        status,
        waktu_pemblokiran
      ];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
