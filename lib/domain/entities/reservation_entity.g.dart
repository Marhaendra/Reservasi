// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationEntity _$ReservationEntityFromJson(Map<String, dynamic> json) =>
    ReservationEntity(
      reservasiId: (json['reservasiId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      nama: json['nama'] as String,
      tanggalReservasi: json['tanggalReservasi'] as String,
      ruanganId: (json['ruanganId'] as num).toInt(),
      kursiId: (json['kursiId'] as num).toInt(),
      nomorKursi: (json['nomorKursi'] as num).toInt(),
      periodeId: (json['periodeId'] as num).toInt(),
      waktuCheckin: json['waktuCheckin'] as String?,
      waktuCheckout: json['waktuCheckout'] as String?,
      status: json['status'] as String,
      kehadiran: (json['kehadiran'] as num).toInt(),
      tanggalPemesanan: json['tanggalPemesanan'] as String,
      ruangan: (json['ruangan'] as List<dynamic>)
          .map((e) => RoomsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      periode: (json['periode'] as List<dynamic>)
          .map((e) => PeriodeEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationEntityToJson(ReservationEntity instance) =>
    <String, dynamic>{
      'reservasiId': instance.reservasiId,
      'userId': instance.userId,
      'nama': instance.nama,
      'tanggalReservasi': instance.tanggalReservasi,
      'ruanganId': instance.ruanganId,
      'kursiId': instance.kursiId,
      'nomorKursi': instance.nomorKursi,
      'periodeId': instance.periodeId,
      'waktuCheckin': instance.waktuCheckin,
      'waktuCheckout': instance.waktuCheckout,
      'status': instance.status,
      'kehadiran': instance.kehadiran,
      'tanggalPemesanan': instance.tanggalPemesanan,
      'ruangan': instance.ruangan.map((e) => e.toJson()).toList(),
      'periode': instance.periode.map((e) => e.toJson()).toList(),
    };
