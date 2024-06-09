// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_period_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsPeriodEntity _$RoomsPeriodEntityFromJson(Map<String, dynamic> json) =>
    RoomsPeriodEntity(
      ruangan_periode_id: (json['ruangan_periode_id'] as num).toInt(),
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      periode_id: (json['periode_id'] as num).toInt(),
      is_active: (json['is_active'] as num).toInt(),
      nama_periode: json['nama_periode'] as String,
      jam_mulai: json['jam_mulai'] as String,
      jam_selesai: json['jam_selesai'] as String,
    );

Map<String, dynamic> _$RoomsPeriodEntityToJson(RoomsPeriodEntity instance) =>
    <String, dynamic>{
      'ruangan_periode_id': instance.ruangan_periode_id,
      'ruangan_id': instance.ruangan_id,
      'periode_id': instance.periode_id,
      'is_active': instance.is_active,
      'nama_periode': instance.nama_periode,
      'jam_mulai': instance.jam_mulai,
      'jam_selesai': instance.jam_selesai,
    };
