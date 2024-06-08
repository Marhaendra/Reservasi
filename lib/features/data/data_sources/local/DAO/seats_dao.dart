import 'dart:async';

import 'package:floor/floor.dart';
import 'package:reservasi/features/data/models/seats_model.dart';

@dao
abstract class SeatsDao {
  final StreamController<void> _changeNotifier =
      StreamController<void>.broadcast();

  Stream<void> get databaseChanges => _changeNotifier.stream;

  @Query('SELECT * FROM seats')
  Stream<List<SeatsModel>> watchAllSeats();

  @Query('SELECT * FROM seats')
  Future<List<SeatsModel>> findAllSeats();

  @Query('SELECT * FROM seats WHERE kursi_id = :id')
  Future<SeatsModel?> findSeatById(int id);

  @Query('SELECT * FROM seats WHERE ruangan_id = :id')
  Future<List<SeatsModel>> findSeatsByRuanganId(int id);

  @Query('DELETE FROM seats')
  Future<void> deleteAllSeats();

  @insert
  Future<void> insertSeat(SeatsModel seat);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSeats(List<SeatsModel> seats);

  @update
  Future<void> updateSeat(SeatsModel seat);

  @delete
  Future<void> deleteSeat(SeatsModel seat);

  void notifyChanges() {
    _changeNotifier.add(null);
  }

  void dispose() {
    _changeNotifier.close();
  }
}
