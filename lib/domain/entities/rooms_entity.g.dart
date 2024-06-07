// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsEntity _$RoomsEntityFromJson(Map<String, dynamic> json) => RoomsEntity(
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      nama_ruangan: json['nama_ruangan'] as String,
    );

Map<String, dynamic> _$RoomsEntityToJson(RoomsEntity instance) =>
    <String, dynamic>{
      'ruangan_id': instance.ruangan_id,
      'nama_ruangan': instance.nama_ruangan,
    };
