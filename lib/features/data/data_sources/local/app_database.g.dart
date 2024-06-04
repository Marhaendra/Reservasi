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

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `LoginModel` (`token` TEXT, `id` TEXT, `role` TEXT, `nama` TEXT, PRIMARY KEY (`token`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LoginDao get loginDao {
    return _loginDaoInstance ??= _$LoginDao(database, changeListener);
  }
}

class _$LoginDao extends LoginDao {
  _$LoginDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _loginModelInsertionAdapter = InsertionAdapter(
            database,
            'LoginModel',
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
    return _queryAdapter.queryList('SELECT * FROM LoginModel',
        mapper: (Map<String, Object?> row) => LoginModel(
            token: row['token'] as String?,
            id: row['id'] as String?,
            role: row['role'] as String?,
            nama: row['nama'] as String?));
  }

  @override
  Future<LoginModel?> findLoginByToken(String token) async {
    return _queryAdapter.query('SELECT * FROM LoginModel WHERE token = ?1',
        mapper: (Map<String, Object?> row) => LoginModel(
            token: row['token'] as String?,
            id: row['id'] as String?,
            role: row['role'] as String?,
            nama: row['nama'] as String?),
        arguments: [token]);
  }

  @override
  Future<void> insertLogin(LoginModel loginModel) async {
    await _loginModelInsertionAdapter.insert(
        loginModel, OnConflictStrategy.replace);
  }
}
