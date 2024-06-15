import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/reservation_entity.dart';

part 'reservation_get_model.g.dart';

@JsonSerializable()
class ReservationGetModel extends ReservationEntity {
  const ReservationGetModel({
    required super.reservasi_id,
    required super.user_id,
    required super.nama,
    required super.tanggal_reservasi,
    required super.ruangan_id,
    required super.kursi_id,
    required super.nomor_kursi,
    required super.periode_id,
    super.waktu_checkin,
    super.waktu_checkout,
    required super.status,
    required super.kehadiran,
    required super.tanggal_pemesanan,
    required super.jam_mulai,
    required super.jam_selesai,
    required super.nama_ruangan,
    required super.nama_periode,
  });

  factory ReservationGetModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationGetModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReservationGetModelToJson(this);
}

@JsonSerializable()
class ReservationGetResponse {
  final String message;
  final List<ReservationGetModel> data;

  ReservationGetResponse({
    required this.message,
    required this.data,
  });

  factory ReservationGetResponse.fromJson(Map<String, dynamic> json) {
    var data = (json['data'] as List)
        .map((item) =>
            ReservationGetModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return ReservationGetResponse(
      message: json['message'] as String,
      data: data,
    );
  }

  Map<String, dynamic> toJson() => _$ReservationGetResponseToJson(this);
}
