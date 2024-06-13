import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/period_entity.dart';
import 'package:reservasi/domain/entities/rooms_entity.dart';
part 'reservation_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ReservationEntity extends Equatable {
  final int reservasiId;
  final int userId;
  final String nama;
  final String tanggalReservasi;
  final int ruanganId;
  final int kursiId;
  final int nomorKursi;
  final int periodeId;
  final String? waktuCheckin;
  final String? waktuCheckout;
  final String status;
  final int kehadiran;
  final String tanggalPemesanan;
  final List<RoomsEntity> ruangan;
  final List<PeriodeEntity> periode;

  const ReservationEntity({
    required this.reservasiId,
    required this.userId,
    required this.nama,
    required this.tanggalReservasi,
    required this.ruanganId,
    required this.kursiId,
    required this.nomorKursi,
    required this.periodeId,
    this.waktuCheckin,
    this.waktuCheckout,
    required this.status,
    required this.kehadiran,
    required this.tanggalPemesanan,
    required this.ruangan,
    required this.periode,
  });

  @override
  List<Object?> get props => [
        reservasiId,
        userId,
        nama,
        tanggalReservasi,
        ruanganId,
        kursiId,
        nomorKursi,
        periodeId,
        waktuCheckin,
        waktuCheckout,
        status,
        kehadiran,
        tanggalPemesanan,
        ruangan,
        periode,
      ];

  factory ReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationEntityToJson(this);
}
