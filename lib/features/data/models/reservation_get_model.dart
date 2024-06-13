import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/period_entity.dart';
import 'package:reservasi/domain/entities/reservation_entity.dart';
import 'package:reservasi/domain/entities/rooms_entity.dart';

part 'reservation_get_model.g.dart';

@JsonSerializable()
class ReservationGetModel extends ReservationEntity {
  ReservationGetModel({
    required int reservasiId,
    required int userId,
    required String nama,
    required String tanggalReservasi,
    required int ruanganId,
    required int kursiId,
    required int nomorKursi,
    required int periodeId,
    String? waktuCheckin,
    String? waktuCheckout,
    required String status,
    required int kehadiran,
    required String tanggalPemesanan,
    required List<RoomsEntity> ruangan,
    required List<PeriodeEntity> periode,
  }) : super(
          reservasiId: reservasiId,
          userId: userId,
          nama: nama,
          tanggalReservasi: tanggalReservasi,
          ruanganId: ruanganId,
          kursiId: kursiId,
          nomorKursi: nomorKursi,
          periodeId: periodeId,
          waktuCheckin: waktuCheckin,
          waktuCheckout: waktuCheckout,
          status: status,
          kehadiran: kehadiran,
          tanggalPemesanan: tanggalPemesanan,
          ruangan: ruangan,
          periode: periode,
        );

  factory ReservationGetModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationGetModelFromJson(json);

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
    // Parse JSON and filter out rooms where deleted_at is not null
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
