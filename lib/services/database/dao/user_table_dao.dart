import 'package:floor/floor.dart';
import 'package:wecheck/services/database/table/user_table.dart';

@dao
abstract class UserTableDao{
  @Query("SELECT * FROM ${UserTable.tableName} WHERE id = :id")
  Future<UserTable?> getUserTableById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(List<UserTable> samples);

  @Query("DELETE FROM ${UserTable.tableName} WHERE id = :id")
  Future<void> deleteUserTableById(String id);

  @Query("SELECT * FROM ${UserTable.tableName}")
  Future<List<UserTable>> getAll();

  @Query("DELETE FROM ${UserTable.tableName}")
  Future deleteAllRows();
}