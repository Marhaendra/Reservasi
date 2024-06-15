// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationGetModel _$ReservationGetModelFromJson(Map<String, dynamic> json) =>
    ReservationGetModel(
      reservasi_id: (json['reservasi_id'] as num).toInt(),
      user_id: (json['user_id'] as num).toInt(),
      nama: json['nama'] as String,
      tanggal_reservasi: json['tanggal_reservasi'] as String,
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      kursi_id: (json['kursi_id'] as num).toInt(),
      nomor_kursi: (json['nomor_kursi'] as num).toInt(),
      periode_id: (json['periode_id'] as num).toInt(),
      waktu_checkin: json['waktu_checkin'] as String?,
      waktu_checkout: json['waktu_checkout'] as String?,
      status: json['status'] as String,
      kehadiran: (json['kehadiran'] as num).toInt(),
      tanggal_pemesanan: json['tanggal_pemesanan'] as String,
      jam_mulai: json['jam_mulai'] as String,
      jam_selesai: json['jam_selesai'] as String,
      nama_ruangan: json['nama_ruangan'] as String,
      nama_periode: json['nama_periode'] as String,
    );

Map<String, dynamic> _$ReservationGetModelToJson(
        ReservationGetModel instance) =>
    <String, dynamic>{
      'reservasi_id': instance.reservasi_id,
      'user_id': instance.user_id,
      'nama': instance.nama,
      'tanggal_reservasi': instance.tanggal_reservasi,
      'ruangan_id': instance.ruangan_id,
      'kursi_id': instance.kursi_id,
      'nomor_kursi': instance.nomor_kursi,
      'periode_id': instance.periode_id,
      'waktu_checkin': instance.waktu_checkin,
      'waktu_checkout': instance.waktu_checkout,
      'status': instance.status,
      'kehadiran': instance.kehadiran,
      'tanggal_pemesanan': instance.tanggal_pemesanan,
      'jam_mulai': instance.jam_mulai,
      'jam_selesai': instance.jam_selesai,
      'nama_periode': instance.nama_periode,
      'nama_ruangan': instance.nama_ruangan,
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
