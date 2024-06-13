// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationGetModel _$ReservationGetModelFromJson(Map<String, dynamic> json) =>
    ReservationGetModel(
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

Map<String, dynamic> _$ReservationGetModelToJson(
        ReservationGetModel instance) =>
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
      'ruangan': instance.ruangan,
      'periode': instance.periode,
    };

ReservationGetResponse _$ReservationGetResponseFromJson(
        Map<String, dynamic> json) =>
    ReservationGetResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReservationGetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationGetResponseToJson(
        ReservationGetResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
