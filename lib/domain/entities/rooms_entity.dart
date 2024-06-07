import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rooms_entity.g.dart';

@JsonSerializable()
class RoomsEntity extends Equatable {
  final int ruangan_id;
  final String nama_ruangan;

  const RoomsEntity({
    required this.ruangan_id,
    required this.nama_ruangan,
  });

  @override
  List<Object?> get props => [
        ruangan_id,
        nama_ruangan,
      ];

  factory RoomsEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsEntityToJson(this);
}
