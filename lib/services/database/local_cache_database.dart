import 'dart:async';

import 'package:wecheck/services/database/dao/sample_dao.dart';
import 'package:wecheck/services/database/table/sample.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_cache_database.g.dart';

@Database(version: 1, entities: [Sample])
abstract class LocalCacheDatabase extends FloorDatabase {
  SampleDao get sampleDao;
}
