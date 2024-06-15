import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'period_entity.g.dart';

@JsonSerializable()
class PeriodeEntity extends Equatable {
  final int periode_id;
  final String nama_periode;
  final String jam_mulai;
  final String jam_selesai;

  const PeriodeEntity({
    required this.periode_id,
    required this.nama_periode,
    required this.jam_mulai,
    required this.jam_selesai,
  });

  @override
  List<Object?> get props => [
        periode_id,
        nama_periode,
        jam_mulai,
        jam_selesai,
      ];

  factory PeriodeEntity.fromJson(Map<String, dynamic> json) =>
      _$PeriodeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodeEntityToJson(this);
}
