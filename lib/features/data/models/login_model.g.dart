// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      id: (json['id'] as num).toInt(),
      role: json['role'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'name': instance.name,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      userData: LoginModel.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userData': instance.userData,
    };

LoginGoogleResponse _$LoginGoogleResponseFromJson(Map<String, dynamic> json) =>
    LoginGoogleResponse(
      data: LoginModel.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginGoogleResponseToJson(
        LoginGoogleResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'token': instance.token,
    };
