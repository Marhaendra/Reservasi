import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity extends Equatable {
  final int id;
  final String role;
  final String name;

  const LoginEntity({
    required this.id,
    required this.role,
    required this.name,
  });

  @override
  List<Object?> get props => [id, role, name];

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
