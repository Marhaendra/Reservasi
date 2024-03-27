// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      nama: json['nama'] as String,
      email: json['email'] as String,
      no_telepon: json['no_telepon'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'email': instance.email,
      'no_telepon': instance.no_telepon,
      'password': instance.password,
    };
