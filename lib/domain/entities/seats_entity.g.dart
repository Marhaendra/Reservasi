// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seats_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatsEntity _$SeatsEntityFromJson(Map<String, dynamic> json) => SeatsEntity(
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      kursi_id: (json['kursi_id'] as num).toInt(),
      isBroken: (json['isBroken'] as num).toInt(),
      nomor_kursi: (json['nomor_kursi'] as num).toInt(),
    );

Map<String, dynamic> _$SeatsEntityToJson(SeatsEntity instance) =>
    <String, dynamic>{
      'ruangan_id': instance.ruangan_id,
      'kursi_id': instance.kursi_id,
      'isBroken': instance.isBroken,
      'nomor_kursi': instance.nomor_kursi,
    };
