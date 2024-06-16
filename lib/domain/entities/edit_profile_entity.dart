import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_entity.g.dart';

@JsonSerializable()
class EditProfileEntity extends Equatable {
  final String id;
  final String nama;
  final String no_telepon;

  const EditProfileEntity({
    required this.id,
    required this.nama,
    required this.no_telepon,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        no_telepon,
      ];

  factory EditProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$EditProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileEntityToJson(this);
}
