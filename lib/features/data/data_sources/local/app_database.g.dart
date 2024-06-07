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

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 6,
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
            'CREATE TABLE IF NOT EXISTS `seats` (`kursi_id` INTEGER NOT NULL, `ruangan_id` INTEGER NOT NULL, `ruangan_id` INTEGER NOT NULL, `kursi_id` INTEGER NOT NULL, FOREIGN KEY (`ruangan_id`) REFERENCES `rooms` (`ruangan_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`kursi_id`, `kursi_id`))');

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
  Future<void> insertRoom(RoomsModel room) async {
    await _roomsModelInsertionAdapter.insert(room, OnConflictStrategy.abort);
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
  )   : _queryAdapter = QueryAdapter(database),
        _seatsModelInsertionAdapter = InsertionAdapter(
            database,
            'seats',
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id
                }),
        _seatsModelUpdateAdapter = UpdateAdapter(
            database,
            'seats',
            ['kursi_id', 'kursi_id'],
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id
                }),
        _seatsModelDeletionAdapter = DeletionAdapter(
            database,
            'seats',
            ['kursi_id', 'kursi_id'],
            (SeatsModel item) => <String, Object?>{
                  'kursi_id': item.kursi_id,
                  'ruangan_id': item.ruangan_id,
                  'ruangan_id': item.ruangan_id,
                  'kursi_id': item.kursi_id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SeatsModel> _seatsModelInsertionAdapter;

  final UpdateAdapter<SeatsModel> _seatsModelUpdateAdapter;

  final DeletionAdapter<SeatsModel> _seatsModelDeletionAdapter;

  @override
  Future<List<SeatsModel>> findAllSeats() async {
    return _queryAdapter.queryList('SELECT * FROM seats',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int));
  }

  @override
  Future<SeatsModel?> findSeatById(int id) async {
    return _queryAdapter.query('SELECT * FROM seats WHERE kursi_id = ?1',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int),
        arguments: [id]);
  }

  @override
  Future<List<SeatsModel>> findSeatsByRuanganId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM seats WHERE ruangan_id = ?1',
        mapper: (Map<String, Object?> row) => SeatsModel(
            kursi_id: row['kursi_id'] as int,
            ruangan_id: row['ruangan_id'] as int),
        arguments: [id]);
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
