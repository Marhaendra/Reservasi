import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_post_entity.g.dart';

@JsonSerializable()
class ReservationPostEntity extends Equatable {
  final int userId;
  final String nama;
  final String tanggalReservasi;
  final int kursiId;
  final int ruanganId;
  final int nomorKursi;
  final int periodeId;

  const ReservationPostEntity({
    required this.userId,
    required this.nama,
    required this.tanggalReservasi,
    required this.kursiId,
    required this.ruanganId,
    required this.nomorKursi,
    required this.periodeId,
  });

  @override
  List<Object?> get props => [
        userId,
        nama,
        tanggalReservasi,
        kursiId,
        ruanganId,
        nomorKursi,
        periodeId,
      ];

  factory ReservationPostEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationPostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationPostEntityToJson(this);
}
