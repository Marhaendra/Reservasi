import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/reservation_post_entity.dart';

part 'reservation_post_model.g.dart';

@JsonSerializable()
class ReservationPostModel extends ReservationPostEntity {
  ReservationPostModel({
    required int userId,
    required String nama,
    required String tanggalReservasi,
    required int kursiId,
    required int ruanganId,
    required int nomorKursi,
    required int periodeId,
  }) : super(
          userId: userId,
          nama: nama,
          tanggalReservasi: tanggalReservasi,
          kursiId: kursiId,
          ruanganId: ruanganId,
          nomorKursi: nomorKursi,
          periodeId: periodeId,
        );

  factory ReservationPostModel.fromJson(Map<String, dynamic> map) =>
      ReservationPostModel(
          userId: map['data'][0]['user_id'],
          nama: map['data'][0]['nama'],
          tanggalReservasi: map['data'][0]['tanggal_reservasi'],
          kursiId: map['data'][0]['kursi_id'],
          ruanganId: map['data'][0]['ruangan_id'],
          nomorKursi: map['data'][0]['nomor_kursi'],
          periodeId: map['data'][0]['periode_id']);

  Map<String, dynamic> toJson() => _$ReservationPostModelToJson(this);
}
