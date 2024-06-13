import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'period_entity.g.dart';

@JsonSerializable()
class PeriodeEntity extends Equatable {
  final int periodeId;
  final String namaPeriode;
  final String jamMulai;
  final String jamSelesai;

  const PeriodeEntity({
    required this.periodeId,
    required this.namaPeriode,
    required this.jamMulai,
    required this.jamSelesai,
  });

  @override
  List<Object?> get props => [
        periodeId,
        namaPeriode,
        jamMulai,
        jamSelesai,
      ];

  factory PeriodeEntity.fromJson(Map<String, dynamic> json) =>
      _$PeriodeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodeEntityToJson(this);
}
