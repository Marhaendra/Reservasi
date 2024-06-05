import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservasi/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@Entity(tableName: 'auth', primaryKeys: ['id'])
@JsonSerializable()
class LoginModel extends LoginEntity {
  final String? token;

  LoginModel({
    required int id,
    required String role,
    required String nama,
    this.token,
  }) : super(id: id, role: role, nama: nama);

  factory LoginModel.fromJson(Map<String, dynamic> map) => LoginModel(
        id: map['userData'][0]['id'],
        token: map['token'],
        role: map['userData'][0]['role'],
        nama: map['userData'][0]['nama'],
      );

  @override
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => super.props..addAll([token]);
}
