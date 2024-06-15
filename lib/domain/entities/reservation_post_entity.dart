import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_post_entity.g.dart';

@JsonSerializable()
class ReservationPostEntity extends Equatable {
  final int user_id;
  final String nama;
  final String tanggal_reservasi;
  final int kursi_id;
  final int ruangan_id;
  final int nomor_kursi;
  final int periode_id;

  const ReservationPostEntity({
    required this.user_id,
    required this.nama,
    required this.tanggal_reservasi,
    required this.kursi_id,
    required this.ruangan_id,
    required this.nomor_kursi,
    required this.periode_id,
  });

  @override
  List<Object?> get props => [
        user_id,
        nama,
        tanggal_reservasi,
        kursi_id,
        ruangan_id,
        nomor_kursi,
        periode_id,
      ];

  factory ReservationPostEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationPostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationPostEntityToJson(this);
}
