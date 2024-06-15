import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reservation_entity.g.dart';

@JsonSerializable()
class ReservationEntity extends Equatable {
  final int reservasi_id;
  final int user_id;
  final String nama;
  final String tanggal_reservasi;
  final int ruangan_id;
  final int kursi_id;
  final int nomor_kursi;
  final int periode_id;
  final String? waktu_checkin;
  final String? waktu_checkout;
  final String status;
  final int kehadiran;
  final String tanggal_pemesanan;
  final String jam_mulai;
  final String jam_selesai;
  final String nama_periode;
  final String nama_ruangan;

  const ReservationEntity({
    required this.reservasi_id,
    required this.user_id,
    required this.nama,
    required this.tanggal_reservasi,
    required this.ruangan_id,
    required this.kursi_id,
    required this.nomor_kursi,
    required this.periode_id,
    this.waktu_checkin,
    this.waktu_checkout,
    required this.status,
    required this.kehadiran,
    required this.tanggal_pemesanan,
    required this.jam_mulai,
    required this.jam_selesai,
    required this.nama_ruangan,
    required this.nama_periode,
  });

  @override
  List<Object?> get props => [
        reservasi_id,
        user_id,
        nama,
        tanggal_reservasi,
        ruangan_id,
        kursi_id,
        nomor_kursi,
        periode_id,
        waktu_checkin,
        waktu_checkout,
        status,
        kehadiran,
        tanggal_pemesanan,
        jam_mulai,
        jam_selesai,
        nama_ruangan,
        nama_periode,
      ];

  factory ReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationEntityToJson(this);
}
