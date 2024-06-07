import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/seats_entity.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';

part 'seats_model.g.dart';

@Entity(tableName: 'seats', primaryKeys: [
  'kursi_id'
], foreignKeys: [
  ForeignKey(
    childColumns: ['ruangan_id'],
    parentColumns: ['ruangan_id'],
    entity: RoomsModel,
  ),
])
@JsonSerializable()
class SeatsModel extends SeatsEntity {
  final int kursi_id;
  final int ruangan_id; // Foreign key to match with RoomsModel

  SeatsModel({
    required this.kursi_id,
    required this.ruangan_id,
  }) : super(ruangan_id: ruangan_id, kursi_id: kursi_id);

  factory SeatsModel.fromJson(Map<String, dynamic> json) =>
      _$SeatsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SeatsModelToJson(this);
}

@JsonSerializable()
class SeatsResponse {
  final String message;
  final List<SeatsModel> data;

  SeatsResponse({
    required this.message,
    required this.data,
  });

  factory SeatsResponse.fromJson(Map<String, dynamic> json) {
    var data = (json['data'] as List)
        .map((item) => SeatsModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return SeatsResponse(
      message: json['message'] as String,
      data: data,
    );
  }

  Map<String, dynamic> toJson() => _$SeatsResponseToJson(this);
}
