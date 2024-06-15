// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationPostEntity _$ReservationPostEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationPostEntity(
      user_id: (json['user_id'] as num).toInt(),
      nama: json['nama'] as String,
      tanggal_reservasi: json['tanggal_reservasi'] as String,
      kursi_id: (json['kursi_id'] as num).toInt(),
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      nomor_kursi: (json['nomor_kursi'] as num).toInt(),
      periode_id: (json['periode_id'] as num).toInt(),
    );

Map<String, dynamic> _$ReservationPostEntityToJson(
        ReservationPostEntity instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'nama': instance.nama,
      'tanggal_reservasi': instance.tanggal_reservasi,
      'kursi_id': instance.kursi_id,
      'ruangan_id': instance.ruangan_id,
      'nomor_kursi': instance.nomor_kursi,
      'periode_id': instance.periode_id,
    };
