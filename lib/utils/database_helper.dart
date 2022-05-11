import 'package:wecheck/services/database/dao/sample_dao.dart';
import 'package:wecheck/services/database/local_cache_database.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();

  late LocalCacheDatabase data;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _databaseHelper;

  Future initDataBase() async {
    data = await $FloorLocalCacheDatabase.databaseBuilder('app_database.db').build();
  }

  SampleDao get sampleDao => data.sampleDao;
}
