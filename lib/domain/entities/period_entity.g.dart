// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodeEntity _$PeriodeEntityFromJson(Map<String, dynamic> json) =>
    PeriodeEntity(
      periode_id: (json['periode_id'] as num).toInt(),
      nama_periode: json['nama_periode'] as String,
      jam_mulai: json['jam_mulai'] as String,
      jam_selesai: json['jam_selesai'] as String,
    );

Map<String, dynamic> _$PeriodeEntityToJson(PeriodeEntity instance) =>
    <String, dynamic>{
      'periode_id': instance.periode_id,
      'nama_periode': instance.nama_periode,
      'jam_mulai': instance.jam_mulai,
      'jam_selesai': instance.jam_selesai,
    };
