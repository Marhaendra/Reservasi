import 'package:reservasi/features/data/models/rooms_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';

class CombinedRoomModel {
  final RoomsModel room;
  final List<SeatsModel> seats;

  CombinedRoomModel({
    required this.room,
    required this.seats,
  });
}
