// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsModel _$RoomsModelFromJson(Map<String, dynamic> json) => RoomsModel(
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      nama_ruangan: json['nama_ruangan'] as String,
      deleted_at: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$RoomsModelToJson(RoomsModel instance) =>
    <String, dynamic>{
      'ruangan_id': instance.ruangan_id,
      'nama_ruangan': instance.nama_ruangan,
      'deleted_at': instance.deleted_at,
    };

RoomsResponse _$RoomsResponseFromJson(Map<String, dynamic> json) =>
    RoomsResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => RoomsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsResponseToJson(RoomsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
