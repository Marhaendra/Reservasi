import 'package:json_annotation/json_annotation.dart';

part 'reservation_check_model.g.dart';

@JsonSerializable()
class ReservationCheckModel {
  final String reservasi_id;

  ReservationCheckModel({required this.reservasi_id});

  factory ReservationCheckModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationCheckModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationCheckModelToJson(this);
}

@JsonSerializable()
class ReservationCheckResponse {
  final String message;
  final List<ReservationCheckModel> data;

  ReservationCheckResponse({
    required this.message,
    required this.data,
  });

  factory ReservationCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationCheckResponseToJson(this);
}
