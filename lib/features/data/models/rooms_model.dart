import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/rooms_entity.dart';

part 'rooms_model.g.dart';

@Entity(tableName: 'rooms', primaryKeys: ['ruangan_id'])
@JsonSerializable()
class RoomsModel extends RoomsEntity {
  final String? deleted_at;

  RoomsModel({
    required int ruangan_id,
    required String nama_ruangan,
    this.deleted_at,
  }) : super(
          ruangan_id: ruangan_id,
          nama_ruangan: nama_ruangan,
        );

  factory RoomsModel.fromJson(Map<String, dynamic> json) =>
      _$RoomsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoomsModelToJson(this);
}

@JsonSerializable()
class RoomsResponse {
  final String message;
  final List<RoomsModel> data;

  RoomsResponse({
    required this.message,
    required this.data,
  });

  factory RoomsResponse.fromJson(Map<String, dynamic> json) {
    // Parse JSON and filter out rooms where deleted_at is not null
    var data = (json['data'] as List)
        .map((item) => RoomsModel.fromJson(item as Map<String, dynamic>))
        .where((room) => room.deleted_at == null)
        .toList();

    return RoomsResponse(
      message: json['message'] as String,
      data: data,
    );
  }

  Map<String, dynamic> toJson() => _$RoomsResponseToJson(this);
}
