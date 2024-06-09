// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatsModel _$SeatsModelFromJson(Map<String, dynamic> json) => SeatsModel(
      kursi_id: (json['kursi_id'] as num).toInt(),
      ruangan_id: (json['ruangan_id'] as num).toInt(),
      isBroken: (json['isBroken'] as num).toInt(),
      nomor_kursi: (json['nomor_kursi'] as num).toInt(),
    );

Map<String, dynamic> _$SeatsModelToJson(SeatsModel instance) =>
    <String, dynamic>{
      'kursi_id': instance.kursi_id,
      'ruangan_id': instance.ruangan_id,
      'isBroken': instance.isBroken,
      'nomor_kursi': instance.nomor_kursi,
    };

SeatsResponse _$SeatsResponseFromJson(Map<String, dynamic> json) =>
    SeatsResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SeatsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatsResponseToJson(SeatsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
