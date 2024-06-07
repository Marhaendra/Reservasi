import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seats_entity.g.dart';

@JsonSerializable()
class SeatsEntity extends Equatable {
  final int ruangan_id;
  final int kursi_id;

  const SeatsEntity({
    required this.ruangan_id,
    required this.kursi_id,
  });

  @override
  List<Object?> get props => [
        ruangan_id,
        kursi_id,
      ];

  factory SeatsEntity.fromJson(Map<String, dynamic> json) =>
      _$SeatsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SeatsEntityToJson(this);
}
