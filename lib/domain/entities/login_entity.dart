import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity extends Equatable {
  final int id;
  final String role;
  final String nama;

  const LoginEntity({
    required this.id,
    required this.role,
    required this.nama,
  });

  @override
  List<Object?> get props => [id, role, nama];

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
