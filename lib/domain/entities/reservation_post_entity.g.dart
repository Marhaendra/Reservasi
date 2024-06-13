// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationPostEntity _$ReservationPostEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationPostEntity(
      userId: (json['userId'] as num).toInt(),
      nama: json['nama'] as String,
      tanggalReservasi: json['tanggalReservasi'] as String,
      kursiId: (json['kursiId'] as num).toInt(),
      ruanganId: (json['ruanganId'] as num).toInt(),
      nomorKursi: (json['nomorKursi'] as num).toInt(),
      periodeId: (json['periodeId'] as num).toInt(),
    );

Map<String, dynamic> _$ReservationPostEntityToJson(
        ReservationPostEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nama': instance.nama,
      'tanggalReservasi': instance.tanggalReservasi,
      'kursiId': instance.kursiId,
      'ruanganId': instance.ruanganId,
      'nomorKursi': instance.nomorKursi,
      'periodeId': instance.periodeId,
    };
