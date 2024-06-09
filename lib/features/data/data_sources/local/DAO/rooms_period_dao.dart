import 'dart:async';
import 'package:floor/floor.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';

@dao
abstract class RoomsPeriodDao {
  final StreamController<void> _changeNotifier =
      StreamController<void>.broadcast();

  Stream<void> get databaseChanges => _changeNotifier.stream;

  @Query('SELECT * FROM rooms_period')
  Stream<List<RoomsPeriodModel>> watchAllRoomsPeriod();

  @Query('SELECT * FROM rooms_period')
  Future<List<RoomsPeriodModel>> findAllRoomsPeriod();

  @Query('SELECT * FROM rooms_period WHERE ruangan_periode_id = :id')
  Future<RoomsPeriodModel?> findRoomsPeriodById(int id);

  @Query('SELECT * FROM rooms_period WHERE ruangan_id = :id')
  Future<List<RoomsPeriodModel>> findRoomsPeriodByRuanganId(int id);

  @Query('DELETE FROM rooms_period')
  Future<void> deleteAllRoomsPeriod();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRoomsPeriod(RoomsPeriodModel roomsPeriod);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRoomsPeriods(List<RoomsPeriodModel> roomsPeriods);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateRoomsPeriod(RoomsPeriodModel roomsPeriod);

  @delete
  Future<void> deleteRoomsPeriod(RoomsPeriodModel roomsPeriod);

  @transaction
  Future<void> insertAndNotify(List<RoomsPeriodModel> roomsPeriods) async {
    await insertRoomsPeriods(roomsPeriods);
    notifyChanges();
  }

  void notifyChanges() {
    _changeNotifier.add(null);
  }

  void dispose() {
    _changeNotifier.close();
  }
}
