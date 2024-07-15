// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      user_id: (json['user_id'] as num).toInt(),
      nama: json['nama'] as String,
      email: json['email'] as String,
      no_telepon: json['no_telepon'] as String,
      tanggal_daftar: json['tanggal_daftar'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      waktu_pemblokiran: json['waktu_pemblokiran'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'nama': instance.nama,
      'email': instance.email,
      'no_telepon': instance.no_telepon,
      'tanggal_daftar': instance.tanggal_daftar,
      'role': instance.role,
      'status': instance.status,
      'waktu_pemblokiran': instance.waktu_pemblokiran,
    };
