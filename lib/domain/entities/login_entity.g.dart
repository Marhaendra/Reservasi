// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
      id: (json['id'] as num).toInt(),
      role: json['role'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'name': instance.name,
    };
