import 'package:wecheck/services/database/table/sample.dart';
import 'package:floor/floor.dart';

@dao
abstract class SampleDao {
  @Query("SELECT * FROM sample_table WHERE id = :id")
  Future<Sample?> getSampleById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(List<Sample> samples);

  @Query("DELETE FROM sample_table WHERE id = :id")
  Future<void> deleteSampleById(String id);
}
