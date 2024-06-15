import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/reservation_post_entity.dart';

part 'reservation_post_model.g.dart';

@JsonSerializable()
class ReservationPostModel extends ReservationPostEntity {
  ReservationPostModel({
    required super.user_id,
    required super.nama,
    required super.tanggal_reservasi,
    required super.kursi_id,
    required super.ruangan_id,
    required super.nomor_kursi,
    required super.periode_id,
  });

  factory ReservationPostModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationPostModelToJson(this);
}
