// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      user_id: (json['user_id'] as num).toInt(),
      nama: json['nama'] as String,
      email: json['email'] as String,
      no_telepon: json['no_telepon'] as String?,
      password: json['password'] as String?,
      tanggal_daftar: json['tanggal_daftar'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      waktu_pemblokiran: json['waktu_pemblokiran'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'nama': instance.nama,
      'email': instance.email,
      'no_telepon': instance.no_telepon,
      'password': instance.password,
      'tanggal_daftar': instance.tanggal_daftar,
      'role': instance.role,
      'status': instance.status,
      'waktu_pemblokiran': instance.waktu_pemblokiran,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
