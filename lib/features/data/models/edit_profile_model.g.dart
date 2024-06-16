// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileModel _$EditProfileModelFromJson(Map<String, dynamic> json) =>
    EditProfileModel(
      id: json['id'] as String,
      nama: json['nama'] as String,
      no_telepon: json['no_telepon'] as String,
    );

Map<String, dynamic> _$EditProfileModelToJson(EditProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'no_telepon': instance.no_telepon,
    };

EditProfileResponse _$EditProfileResponseFromJson(Map<String, dynamic> json) =>
    EditProfileResponse(
      message: json['message'] as String,
      data: EditProfileModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditProfileResponseToJson(
        EditProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
