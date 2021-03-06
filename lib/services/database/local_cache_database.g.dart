// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cache_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorLocalCacheDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalCacheDatabaseBuilder databaseBuilder(String name) =>
      _$LocalCacheDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalCacheDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$LocalCacheDatabaseBuilder(null);

}

class _$LocalCacheDatabaseBuilder {
  _$LocalCacheDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$LocalCacheDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$LocalCacheDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<LocalCacheDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LocalCacheDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }

  Future dropDB() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LocalCacheDatabase();
    await database.close();
  }
}

class _$LocalCacheDatabase extends LocalCacheDatabase {
  _$LocalCacheDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SampleDao? _sampleDaoInstance;
  UserTableDao? _userTableDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `sample_table` (`id` TEXT, `name` TEXT, `dateUpdated` INTEGER, `dateCreated` INTEGER, PRIMARY KEY (`id`))');
        await database
            .execute('''CREATE TABLE IF NOT EXISTS ${UserTable.tableName} (
             `${UserTable.idField}` TEXT,
             `${UserTable.firstNameField}` TEXT,
             `${UserTable.lastNameField}` TEXT,
             `${UserTable.birthDayField}` TEXT,
             `${UserTable.sexField}` INTEGER,
             `${UserTable.countryField}` TEXT,
             `${UserTable.heighField}` DOUBLE,
             `${UserTable.weightField}` DOUBLE,
             `${UserTable.phoneField}` TEXT,
             `${UserTable.syncedTimeField}` TEXT,
             `${UserTable.imageField}` TEXT,
             `${UserTable.diabeteField}` TEXT,
             `${UserTable.isSyncedField}` INTEGER,
             `${UserTable.updatedAtField}` TEXT,
             `${UserTable.createdAtField}` TEXT
            )''');
        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SampleDao get sampleDao {
    return _sampleDaoInstance ??= _$SampleDao(database, changeListener);
  }

  @override
  UserTableDao get userTableDao {
    return _userTableDaoInstance ??= _$UserTableDao(database, changeListener);
  }
}

class _$UserTableDao extends UserTableDao {
  _$UserTableDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userTableInsertionAdapter = InsertionAdapter(
          database,
          UserTable.tableName,
          (UserTable item) => <String, Object?>{
            UserTable.idField: item.id,
            UserTable.firstNameField: item.firstName,
            UserTable.lastNameField: item.lastName,
            UserTable.birthDayField: item.birthDay,
            UserTable.sexField: item.sex,
            UserTable.countryField: item.country,
            UserTable.heighField: item.heigh,
            UserTable.weightField: item.weight,
            UserTable.phoneField: item.phone,
            UserTable.emailField: item.email,
            UserTable.syncedTimeField: item.syncedTime,
            UserTable.imageField: item.image,
            UserTable.diabeteField: item.diabete,
            UserTable.isSyncedField: item.isSynced,
            UserTable.updatedAtField: item.updatedAt,
            UserTable.createdAtField: item.createdAt,
          },
        );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserTable> _userTableInsertionAdapter;

  @override
  Future<UserTable?> getUserTableById(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM ${UserTable.tableName} WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            UserTable.fromMap(Map<String, dynamic>.from(row)),
        arguments: [id]);
  }

  @override
  Future<void> deleteUserTableById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ${UserTable.tableName} WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insert(List<UserTable> userTables) async {
    print("canhdt1 insert");
    userTables.forEach((element) {
      print(element.id);
    });
    await _userTableInsertionAdapter.insertList(
        userTables, OnConflictStrategy.replace);
  }

  @override
  Future<List<UserTable>> getAll() async {
    return _queryAdapter.queryList(
      'SELECT * FROM ${UserTable.tableName}',
      mapper: (Map<String, Object?> row) =>
          UserTable.fromMap(Map<String, dynamic>.from(row)),
    );
  }

  @override
  Future<void> deleteAllRows() async{
    await _queryAdapter.queryNoReturn("DELETE FROM ${UserTable.tableName}");
  }
}

class _$SampleDao extends SampleDao {
  _$SampleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sampleInsertionAdapter = InsertionAdapter(
          database,
          'sample_table',
          (Sample item) => <String, Object?>{
            'id': item.id,
            'name': item.name,
            'dateUpdated': item.dateUpdated,
            'dateCreated': item.dateCreated
          },
        );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sample> _sampleInsertionAdapter;

  @override
  Future<Sample?> getSampleById(String id) async {
    return _queryAdapter.query('SELECT * FROM sample_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Sample.fromMap(Map<String, dynamic>.from(row)),
        arguments: [id]);
  }

  @override
  Future<void> deleteSampleById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM sample_table WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insert(List<Sample> samples) async {
    await _sampleInsertionAdapter.insertList(
        samples, OnConflictStrategy.replace);
  }
}
