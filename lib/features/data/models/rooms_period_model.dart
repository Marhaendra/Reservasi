import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/rooms_period_entity.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';

part 'rooms_period_model.g.dart';

@Entity(tableName: 'rooms_period', primaryKeys: [
  'ruangan_periode_id'
], foreignKeys: [
  ForeignKey(
    childColumns: ['ruangan_id'],
    parentColumns: ['ruangan_id'],
    entity: RoomsModel,
  ),
])
@JsonSerializable()
class RoomsPeriodModel extends RoomsPeriodEntity {
  RoomsPeriodModel({
    required int ruangan_periode_id,
    required int ruangan_id,
    required int periode_id,
    required int is_active,
    required String nama_periode,
    required String jam_mulai,
    required String jam_selesai,
  }) : super(
          ruangan_periode_id: ruangan_periode_id,
          ruangan_id: ruangan_id,
          periode_id: periode_id,
          is_active: is_active,
          nama_periode: nama_periode,
          jam_mulai: jam_mulai,
          jam_selesai: jam_selesai,
        );

  factory RoomsPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$RoomsPeriodModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoomsPeriodModelToJson(this);
}

@JsonSerializable()
class RoomsPeriodResponse {
  final String message;
  final List<RoomsPeriodModel> data;

  RoomsPeriodResponse({
    required this.message,
    required this.data,
  });

  factory RoomsPeriodResponse.fromJson(Map<String, dynamic> json) {
    var data = (json['data'] as List)
        .map((item) => RoomsPeriodModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return RoomsPeriodResponse(
      message: json['message'] as String,
      data: data,
    );
  }

  Map<String, dynamic> toJson() => _$RoomsPeriodResponseToJson(this);
}
