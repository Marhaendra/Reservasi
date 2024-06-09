import 'package:floor/floor.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/login_dao.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/rooms_dao.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/rooms_period_dao.dart';
import 'package:reservasi/features/data/data_sources/local/DAO/seats_dao.dart';
import 'package:reservasi/features/data/models/login_model.dart';
import 'package:reservasi/features/data/models/rooms_model.dart';
import 'package:reservasi/features/data/models/rooms_period_model.dart';
import 'package:reservasi/features/data/models/seats_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart'; // the generated code will be there

@Database(
    version: 9,
    entities: [LoginModel, RoomsModel, SeatsModel, RoomsPeriodModel])
abstract class AppDatabase extends FloorDatabase {
  LoginDao get loginDao;
  RoomsDao get roomsDao;
  SeatsDao get seatsDao;
  RoomsPeriodDao get roomsPeriodDao;

  static AppDatabase? _databaseInstance;

  static Future<AppDatabase> getDatabase() async {
    // Return the AppDatabase instance
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  static Future<void> closed() async {
    await _databaseInstance?.close();
    _databaseInstance = null;
  }

  static set databaseInstance(AppDatabase? instance) {
    _databaseInstance = instance;
  }

  static final migration7to8 = Migration(7, 8, (database) async {
    await database.execute(
        'ALTER TABLE seats ADD COLUMN isBroken INTEGER NOT NULL DEFAULT 0');
    await database.execute(
        'ALTER TABLE seats ADD COLUMN nomor_kursi INTEGER NOT NULL DEFAULT 0');
    print("Migration from version 7 to 8 applied successfully.");
  });

  static final migration8to9 = Migration(8, 9, (database) async {
    await database.execute('ALTER TABLE seats RENAME TO seats_old');
    await database.execute('''
      CREATE TABLE seats (
        kursi_id INTEGER PRIMARY KEY AUTOINCREMENT,
        ruangan_id INTEGER NOT NULL,
        isBroken INTEGER NOT NULL DEFAULT 0,
        nomor_kursi INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (ruangan_id) REFERENCES rooms(ruangan_id)
      )
    ''');
    await database.execute('''
      INSERT INTO seats (kursi_id, ruangan_id, isBroken, nomor_kursi)
      SELECT kursi_id, ruangan_id, isBroken,
             CASE 
               WHEN nomor_kursi IS NULL OR TRIM(nomor_kursi) = '' THEN 0
               ELSE CAST(nomor_kursi AS INTEGER)
             END
      FROM seats_old
    ''');
    await database.execute('DROP TABLE seats_old');

    print("Migration from version 8 to 9 applied successfully.");
  });

  static final migration6to7 = Migration(6, 7, (database) async {
    await database.execute('DROP TABLE IF EXISTS rooms_period');

    await database.execute('''
    CREATE TABLE IF NOT EXISTS rooms_period (
      ruangan_periode_id INTEGER PRIMARY KEY,
      ruangan_id INTEGER,
      periode_id INTEGER,
      is_active INTEGER,
      nama_periode STRING,
      jam_mulai STRING,
      jam_selesai STRING,
      FOREIGN KEY (ruangan_id) REFERENCES rooms(ruangan_id)
    )
  ''');
    print("Migration from version 6 to 7 applied successfully.");
  });

  static final migration5to6 = Migration(5, 6, (database) async {
    await database.execute('DROP TABLE IF EXISTS seats');

    await database.execute('''
    CREATE TABLE IF NOT EXISTS seats (
      kursi_id INTEGER PRIMARY KEY,
      ruangan_id INTEGER,
      FOREIGN KEY (ruangan_id) REFERENCES rooms(ruangan_id)
    )
  ''');
    print("Migration from version 5 to 6 applied successfully.");
  });

  static final migration4to5 = Migration(4, 5, (database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS seats (
      kursi_id INTEGER PRIMARY KEY,
      'ruangan_id INTEGER, '
        'FOREIGN KEY (ruangan_id) REFERENCES rooms(ruangan_id)'
    )
  ''');
    print("Migration from version 4 to 5 applied successfully.");
  });

  static final migration3to4 = Migration(3, 4, (database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS rooms (
      ruangan_id INTEGER PRIMARY KEY,
      nama_ruangan STRING,
      deleted_at STRING
    )
  ''');
    print("Migration from version 3 to 4 applied successfully.");
  });

  // static final MigrationFrom2To3 = Migration(2, 3, (database) async {
  //   // Close the existing database connection
  //   await closed();

  //   await database.execute('ALTER TABLE seats DROP COLUMN ruangan_id');
  //   await database.execute('ALTER TABLE rooms DROP COLUMN ruangan_id');

  //   // Add more SQL statements as needed for your migration
  //   await database.execute('DROP TABLE IF EXISTS auth');
  //   await database.execute('DROP TABLE IF EXISTS rooms');
  //   await database.execute('DROP TABLE IF EXISTS seats');

  //   // Recreate tables
  //   await database.execute('CREATE TABLE IF NOT EXISTS auth ('
  //       'id INTEGER PRIMARY KEY, '
  //       'role STRING, nama STRING)');

  //   await database.execute('CREATE TABLE IF NOT EXISTS rooms ('
  //       'ruangan_id INTEGER PRIMARY KEY, '
  //       'nama_ruangan STRING, '
  //       'deleted_at STRING)');

  //   await database.execute('CREATE TABLE IF NOT EXISTS seats ('
  //       'kursi_id INTEGER PRIMARY KEY, '
  //       'ruangan_id INTEGER,)');
  // });
}
