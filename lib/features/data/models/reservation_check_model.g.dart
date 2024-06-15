// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_check_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationCheckModel _$ReservationCheckModelFromJson(
        Map<String, dynamic> json) =>
    ReservationCheckModel(
      reservasi_id: json['reservasi_id'] as String,
    );

Map<String, dynamic> _$ReservationCheckModelToJson(
        ReservationCheckModel instance) =>
    <String, dynamic>{
      'reservasi_id': instance.reservasi_id,
    };

ReservationCheckResponse _$ReservationCheckResponseFromJson(
        Map<String, dynamic> json) =>
    ReservationCheckResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReservationCheckModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationCheckResponseToJson(
        ReservationCheckResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
