import 'package:wecheck/utils/extensions.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "sample_table", primaryKeys: ["id"])
class Sample {
  @primaryKey
  String? id;
  String? name;
  int? dateUpdated;
  int? dateCreated;

  @ignore
  Sample.fromMap(Map<String, dynamic> data) {
    id = data["id"]?.toString();
    name = data["name"]?.toString();
    dateUpdated = data["dateUpdated"]?.toString().toInt();
    dateCreated = data["dateCreated"]?.toString().toInt();
  }

  @ignore
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["dateUpdated"] = dateUpdated;
    data["dateCreated"] = dateCreated;
    return data;
  }
}
