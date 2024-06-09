import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rooms_period_entity.g.dart';

@JsonSerializable()
class RoomsPeriodEntity extends Equatable {
  final int ruangan_periode_id;
  final int ruangan_id;
  final int periode_id;
  final int is_active;
  final String nama_periode;
  final String jam_mulai;
  final String jam_selesai;

  const RoomsPeriodEntity({
    required this.ruangan_periode_id,
    required this.ruangan_id,
    required this.periode_id,
    required this.is_active,
    required this.nama_periode,
    required this.jam_mulai,
    required this.jam_selesai,
  });

  @override
  List<Object?> get props => [
        ruangan_periode_id,
        ruangan_id,
        periode_id,
        is_active,
        nama_periode,
        jam_mulai,
        jam_selesai,
      ];

  factory RoomsPeriodEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomsPeriodEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsPeriodEntityToJson(this);
}
