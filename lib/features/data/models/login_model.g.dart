// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      id: (json['id'] as num).toInt(),
      role: json['role'] as String,
      nama: json['nama'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'nama': instance.nama,
      'token': instance.token,
    };
