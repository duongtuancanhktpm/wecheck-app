import 'package:wecheck/services/database/dao/sample_dao.dart';
import 'package:wecheck/services/database/dao/user_table_dao.dart';
import 'package:wecheck/services/database/local_cache_database.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();

  late LocalCacheDatabase data;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _databaseHelper;

  Future initDataBase() async {
    data = await $FloorLocalCacheDatabase.databaseBuilder('app_database.db').build();
  }
  Future dropDB() async{
    await $FloorLocalCacheDatabase.databaseBuilder('app_database.db').dropDB();
  }
  SampleDao get sampleDao => data.sampleDao;
  UserTableDao get userTableDao => data.userTableDao;
}
