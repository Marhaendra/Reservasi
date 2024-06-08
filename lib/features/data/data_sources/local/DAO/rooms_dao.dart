import 'package:floor/floor.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';

@dao
abstract class RoomsDao {
  @Query('SELECT * FROM rooms')
  Future<List<RoomsModel>> findAllRooms();

  @Query('SELECT * FROM rooms WHERE ruangan_id = :id')
  Future<RoomsModel?> findRoomById(int id);

  @Query('DELETE FROM rooms')
  Future<void> deleteAllRooms();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRoom(RoomsModel room);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRooms(List<RoomsModel> rooms);

  @update
  Future<void> updateRoom(RoomsModel room);

  @delete
  Future<void> deleteRoom(RoomsModel room);
}
