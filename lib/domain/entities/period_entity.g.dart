// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodeEntity _$PeriodeEntityFromJson(Map<String, dynamic> json) =>
    PeriodeEntity(
      periodeId: (json['periodeId'] as num).toInt(),
      namaPeriode: json['namaPeriode'] as String,
      jamMulai: json['jamMulai'] as String,
      jamSelesai: json['jamSelesai'] as String,
    );

Map<String, dynamic> _$PeriodeEntityToJson(PeriodeEntity instance) =>
    <String, dynamic>{
      'periodeId': instance.periodeId,
      'namaPeriode': instance.namaPeriode,
      'jamMulai': instance.jamMulai,
      'jamSelesai': instance.jamSelesai,
    };
