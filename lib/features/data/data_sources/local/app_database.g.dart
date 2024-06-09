// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LoginDao? _loginDaoInstance;

  RoomsDao? _roomsDaoInstance;

  SeatsDao? _seatsDaoInstance;

  RoomsPeriodDao? _roomsPeriodDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 9,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `auth` (`token` TEXT, `id` INTEGER NOT NULL, `role` TEXT NOT NULL, `nama` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rooms` (`deleted_at` TEXT, `ruangan_id` INTEGER NOT NULL, `nama_ruangan` TEXT NOT NULL, PRIMARY KEY (`ruangan_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `seats` (`kursi_id` INTEGER NOT NULL, `ruangan_id` INTEGER NOT NULL, `isBroken` INTEGER NOT NULL, `nomor_kursi` INTEGER NOT NULL, `ruangan_id` INTEGER NOT NULL, `kursi_id` INTEGER NOT NULL, `isBroken` INTEGER NOT NULL, `nomor_kursi` INTEGER NOT NULL, FOREIGN KEY (`ruangan_id`) REFERENCES `rooms` (`ruangan_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`kursi_id`, `kursi_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rooms_period` (`ruangan_periode_id` INTEGER NOT NULL, `ruangan_id` INTEGER NOT NULL, `periode_id` INTEGER NOT NULL, `is_active` INTEGER NOT NULL, `nama_periode` TEXT NOT NULL, `jam_mulai` TEXT NOT NULL, `jam_selesai` TEXT NOT NULL, FOREIGN KEY (`ruangan_id`) REFERENCES `rooms` (`ruangan_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`ruangan_periode_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LoginDao get loginDao {
    return _loginDaoInstance ??= _$LoginDao(database, changeListener);
  }

  @override
  RoomsDao get roomsDao {
    return _roomsDaoInstance ??= _$RoomsDao(database, changeListener);
  }

  @override
  SeatsDao get seatsDao {
    return _seatsDaoInstance ??= _$SeatsDao(database, changeListener);
  }

  @override
  RoomsPeriodDao get roomsPeriodDao {
    return _roomsPeriodDaoInstance ??=
        _$RoomsPeriodDao(database, changeListener);
  }
}

class _$LoginDao extends LoginDao {
  _$LoginDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _loginModelInsertionAdapter = InsertionAdapter(
            database,
            'auth',
            (LoginModel item) => <String, Object?>{
                  'token': item.token,
                  'id': item.id,
                  'role': item.role,
                  'nama': item.nama
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LoginModel> _loginModelInsertionAdapter;

  @override
  Future<List<LoginModel>> getUserData() async {
    return _queryAdapter.queryList('SELECT * FROM auth',
        mapper: (Map<String, Object?> row) => LoginModel(
            id: row['id'] as int,
            role: row['role'] as String,
            nama: row['nama'] as String,
            token: row['token'] as String?));
  }

  @override
  Future<LoginModel?> findLoginByToken(String token) async {
    return _queryAdapter.query('SELECT * FROM auth WHERE token = ?1',
        mapper: (Map<String, Object?> row) => LoginModel(
            id: row['id'] as int,
            role: row['role'] as String,
            nama: row['nama'] as String,
            token: row['token'] as String?),
        arguments: [token]);
  }

  @override
  Future<void> insertLogin(LoginModel auth) async {
    await _loginModelInsertionAdapter.insert(auth, OnConflictStrategy.replace);
  }
}

class _$RoomsDao extends RoomsDao {
  _$RoomsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _roomsModelInsertionAdapter = InsertionAdapter(
            database,
            'rooms',
            (RoomsModel item) => <String, Object?>{
                  'deleted_at': item.deleted_at,
                  'ruangan_id': item.ruangan_id,
                  'nama_ruangan': item.nama_ruangan
                }),
        _roomsModelUpdateAdapter = UpdateAdapter(
            database,
            'rooms',
            ['ruangan_id'],
            (RoomsModel item) => <String, Object?>{
                  'deleted_at': item.deleted_at,
                  'ruangan_id': item.ruangan_id,
                  'nama_ruangan': item.nama_ruangan
                }),
        _roomsModelDeletionAdapter = DeletionAdapter(
            database,
            'rooms',
            ['ruangan_id'],
            (RoomsModel item) => <String, Object?>{
                  'deleted_at': item.deleted_at,
                  'ruangan_id': item.ruangan_id,
                  'nama_ruangan': item.nama_ruangan
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomsModel> _roomsModelInsertionAdapter;

  final UpdateAdapter<RoomsModel> _roomsModelUpdateAdapter;

  final DeletionAdapter<RoomsModel> _roomsModelDeletionAdapter;

  @override
  Future<List<RoomsModel>> findAllRooms() async {
    return _queryAdapter.queryList('SELECT * FROM rooms',
        mapper: (Map<String, Object?> row) => RoomsModel(
            ruangan_id: row['ruangan_id'] as int,
            nama_ruangan: row['nama_ruangan'] as String,
            deleted_at: row['deleted_at'] as String?));
  }

  @override
  Future<RoomsModel?> findRoomById(int id) async {
    return _queryAdapter.query('SELECT * FROM rooms WHERE ruangan_id = ?1',
        mapper: (Map<String, Object?> row) => RoomsModel(
            ruangan_id: row['ruangan_id'] as int,
            nama_ruangan: row['nama_ruangan'] as String,
            deleted_at: row['deleted_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllRooms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM rooms');
  }

  @override
  Future<void> insertRoom(RoomsModel room) async {
    await _roomsModelInsertionAdapter.insert(room, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertRooms(List<RoomsModel> rooms) async {
    await _roomsModelInsertionAdapter.insertList(
        rooms, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateRoom(RoomsModel room) async {
    await _roomsModelUpdateAdapter.update(room, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRoom(RoomsModel room) async {
    await _roomsModelDeletionAdapter.delete(room);
  }
}

class _$SeatsDao extends SeatsDao {
  _$SeatsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _seatsModelInsertionAdapter = InsertionAdapter(
            database,
            'seats',
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi
                },
            changeListener),
        _seatsModelUpdateAdapter = UpdateAdapter(
            database,
            'seats',
            ['kursi_id', 'kursi_id'],
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi
                },
            changeListener),
        _seatsModelDeletionAdapter = DeletionAdapter(
            database,
            'seats',
            ['kursi_id', 'kursi_id'],
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id,
                  'isBroken': item.isBroken,
                  'nomor_kursi': item.nomor_kursi
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SeatsModel> _seatsModelInsertionAdapter;

  final UpdateAdapter<SeatsModel> _seatsModelUpdateAdapter;

  final DeletionAdapter<SeatsModel> _seatsModelDeletionAdapter;

  @override
  Stream<List<SeatsModel>> watchAllSeats() {
    return _queryAdapter.queryListStream('SELECT * FROM seats',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            isBroken: row['isBroken'] as int,
            nomor_kursi: row['nomor_kursi'] as int),
        queryableName: 'seats',
        isView: false);
  }

  @override
  Future<List<SeatsModel>> findAllSeats() async {
    return _queryAdapter.queryList('SELECT * FROM seats',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            isBroken: row['isBroken'] as int,
            nomor_kursi: row['nomor_kursi'] as int));
  }

  @override
  Future<SeatsModel?> findSeatById(int id) async {
    return _queryAdapter.query('SELECT * FROM seats WHERE kursi_id = ?1',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            isBroken: row['isBroken'] as int,
            nomor_kursi: row['nomor_kursi'] as int),
        arguments: [id]);
  }

  @override
  Future<List<SeatsModel>> findSeatsByRuanganId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM seats WHERE ruangan_id = ?1',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            isBroken: row['isBroken'] as int,
            nomor_kursi: row['nomor_kursi'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllSeats() async {
    await _queryAdapter.queryNoReturn('DELETE FROM seats');
  }

  @override
  Future<void> insertSeat(SeatsModel seat) async {
    await _seatsModelInsertionAdapter.insert(seat, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSeats(List<SeatsModel> seats) async {
    await _seatsModelInsertionAdapter.insertList(
        seats, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateSeat(SeatsModel seat) async {
    await _seatsModelUpdateAdapter.update(seat, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSeat(SeatsModel seat) async {
    await _seatsModelDeletionAdapter.delete(seat);
  }
}

class _$RoomsPeriodDao extends RoomsPeriodDao {
  _$RoomsPeriodDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _roomsPeriodModelInsertionAdapter = InsertionAdapter(
            database,
            'rooms_period',
            (RoomsPeriodModel item) => <String, Object?>{
                  'ruangan_periode_id': item.ruangan_periode_id,
                  'ruangan_id': item.ruangan_id,
                  'periode_id': item.periode_id,
                  'is_active': item.is_active,
                  'nama_periode': item.nama_periode,
                  'jam_mulai': item.jam_mulai,
                  'jam_selesai': item.jam_selesai
                },
            changeListener),
        _roomsPeriodModelUpdateAdapter = UpdateAdapter(
            database,
            'rooms_period',
            ['ruangan_periode_id'],
            (RoomsPeriodModel item) => <String, Object?>{
                  'ruangan_periode_id': item.ruangan_periode_id,
                  'ruangan_id': item.ruangan_id,
                  'periode_id': item.periode_id,
                  'is_active': item.is_active,
                  'nama_periode': item.nama_periode,
                  'jam_mulai': item.jam_mulai,
                  'jam_selesai': item.jam_selesai
                },
            changeListener),
        _roomsPeriodModelDeletionAdapter = DeletionAdapter(
            database,
            'rooms_period',
            ['ruangan_periode_id'],
            (RoomsPeriodModel item) => <String, Object?>{
                  'ruangan_periode_id': item.ruangan_periode_id,
                  'ruangan_id': item.ruangan_id,
                  'periode_id': item.periode_id,
                  'is_active': item.is_active,
                  'nama_periode': item.nama_periode,
                  'jam_mulai': item.jam_mulai,
                  'jam_selesai': item.jam_selesai
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomsPeriodModel> _roomsPeriodModelInsertionAdapter;

  final UpdateAdapter<RoomsPeriodModel> _roomsPeriodModelUpdateAdapter;

  final DeletionAdapter<RoomsPeriodModel> _roomsPeriodModelDeletionAdapter;

  @override
  Stream<List<RoomsPeriodModel>> watchAllRoomsPeriod() {
    return _queryAdapter.queryListStream('SELECT * FROM rooms_period',
        mapper: (Map<String, Object?> row) => RoomsPeriodModel(
            ruangan_periode_id: row['ruangan_periode_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            periode_id: row['periode_id'] as int,
            is_active: row['is_active'] as int,
            nama_periode: row['nama_periode'] as String,
            jam_mulai: row['jam_mulai'] as String,
            jam_selesai: row['jam_selesai'] as String),
        queryableName: 'rooms_period',
        isView: false);
  }

  @override
  Future<List<RoomsPeriodModel>> findAllRoomsPeriod() async {
    return _queryAdapter.queryList('SELECT * FROM rooms_period',
        mapper: (Map<String, Object?> row) => RoomsPeriodModel(
            ruangan_periode_id: row['ruangan_periode_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            periode_id: row['periode_id'] as int,
            is_active: row['is_active'] as int,
            nama_periode: row['nama_periode'] as String,
            jam_mulai: row['jam_mulai'] as String,
            jam_selesai: row['jam_selesai'] as String));
  }

  @override
  Future<RoomsPeriodModel?> findRoomsPeriodById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM rooms_period WHERE ruangan_periode_id = ?1',
        mapper: (Map<String, Object?> row) => RoomsPeriodModel(
            ruangan_periode_id: row['ruangan_periode_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            periode_id: row['periode_id'] as int,
            is_active: row['is_active'] as int,
            nama_periode: row['nama_periode'] as String,
            jam_mulai: row['jam_mulai'] as String,
            jam_selesai: row['jam_selesai'] as String),
        arguments: [id]);
  }

  @override
  Future<List<RoomsPeriodModel>> findRoomsPeriodByRuanganId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM rooms_period WHERE ruangan_id = ?1',
        mapper: (Map<String, Object?> row) => RoomsPeriodModel(
            ruangan_periode_id: row['ruangan_periode_id'] as int,
            ruangan_id: row['ruangan_id'] as int,
            periode_id: row['periode_id'] as int,
            is_active: row['is_active'] as int,
            nama_periode: row['nama_periode'] as String,
            jam_mulai: row['jam_mulai'] as String,
            jam_selesai: row['jam_selesai'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllRoomsPeriod() async {
    await _queryAdapter.queryNoReturn('DELETE FROM rooms_period');
  }

  @override
  Future<void> insertRoomsPeriod(RoomsPeriodModel roomsPeriod) async {
    await _roomsPeriodModelInsertionAdapter.insert(
        roomsPeriod, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertRoomsPeriods(List<RoomsPeriodModel> roomsPeriods) async {
    await _roomsPeriodModelInsertionAdapter.insertList(
        roomsPeriods, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateRoomsPeriod(RoomsPeriodModel roomsPeriod) async {
    await _roomsPeriodModelUpdateAdapter.update(
        roomsPeriod, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRoomsPeriod(RoomsPeriodModel roomsPeriod) async {
    await _roomsPeriodModelDeletionAdapter.delete(roomsPeriod);
  }

  @override
  Future<void> insertAndNotify(List<RoomsPeriodModel> roomsPeriods) async {
    if (database is sqflite.Transaction) {
      await super.insertAndNotify(roomsPeriods);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.roomsPeriodDao.insertAndNotify(roomsPeriods);
      });
    }
  }
}
