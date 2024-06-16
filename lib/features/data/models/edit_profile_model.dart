import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/edit_profile_entity.dart';

part 'edit_profile_model.g.dart';

@JsonSerializable()
class EditProfileModel extends EditProfileEntity {
  EditProfileModel({
    required String id,
    required String nama,
    required String no_telepon,
  }) : super(id: id, nama: nama, no_telepon: no_telepon);

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileModelToJson(this);
}

@JsonSerializable()
class EditProfileResponse {
  final String message;
  final EditProfileModel data;

  EditProfileResponse({
    required this.message,
    required this.data,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);
}
