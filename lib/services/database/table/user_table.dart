import 'package:floor/floor.dart';
import 'package:wecheck/utils/extensions.dart';

@Entity(tableName: "user", primaryKeys: ["id"])
class UserTable {
  static const String tableName = "user";
  @primaryKey
  String? id;
  static const String idField = "id";

  String? firstName;
  static const String firstNameFiled = "first_name";

  String? lastName;
  static const String lastNameFiled = "last_name";

  String? birthDay;
  static const String birthDayFiled = "birth_day";

  int? sex;
  static const String sexFiled = "sex";

  String? country;
  static const String countryFiled = "country";

  double? heigh;
  static const String heighFiled = "heigh";

  double? weight;
  static const String weightFiled = "weight";

  String? phone;
  static const String phoneFiled = "phone";

  String? syncedTime;
  static const String syncedTimeFiled = "synced_time";

  String? image;
  static const String imageFiled = "image";

  String? diabete;
  static const String diabeteFiled = "diabete";

  int? isSynced;
  static const String isSyncedFiled = "is_synced";

  String? updatedAt;
  static const String updatedAtFiled = "updated_at";

  String? createdAt;
  static const String createdAtFiled = "created_at";

  UserTable({
    String? id,
    String? firstName,
    String? lastName,
    String? birthDay,
    int? sex,
    String? country,
    double? heigh,
    double? weight,
    String? phone,
    String? syncedTime,
    String? image,
    String? diabete,
    int? isSynced,
    String? updatedAt,
    String? createdAt,
  }){
    this.id = id;
    this.firstName=firstName;
    this.lastName = lastName;
    this.birthDay = birthDay;
    this.sex = sex;
    this.country = country;
    this.heigh = heigh;
    this.weight = weight;
    this.phone = phone;
    this.syncedTime = syncedTime;
    this.image = image;
    this.diabete = diabete;
    this.isSynced = isSynced;
    this.updatedAt = updatedAt;
    this.createdAt = createdAt;
  }

  @ignore
  UserTable.fromMap(Map<String, dynamic> data) {
    id = data[idField]?.toString();
    firstName = data[firstNameFiled]?.toString();
    lastName = data[lastNameFiled]?.toString();
    birthDay = data[birthDayFiled]?.toString();
    sex = data[sexFiled]?.toString().toInt();
    country = data[countryFiled]?.toString();
    heigh = double.parse(data[heighFiled]?.toString() ?? "-1");
    weight = double.parse(data[weightFiled]?.toString() ?? "-1");
    phone = data[phoneFiled]?.toString();
    syncedTime = data[syncedTimeFiled]?.toString();
    image = data[imageFiled]?.toString();
    diabete = data[diabeteFiled]?.toString();
    isSynced = data[isSyncedFiled].toString().toInt();
    updatedAt = data[updatedAtFiled]?.toString();
    createdAt = data[createdAtFiled]?.toString();
  }

  @ignore
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data[idField] = id;
    data[firstNameFiled] = firstName;
    data[lastNameFiled] = lastNameFiled;
    data[birthDayFiled] = birthDay;
    data[sexFiled] = sex;
    data[countryFiled] = country;
    data[heighFiled] = heigh;
    data[weightFiled] = weight;
    data[phoneFiled] = phone;
    data[syncedTimeFiled] = syncedTime;
    data[imageFiled] = image;
    data[diabeteFiled] = diabete;
    data[isSyncedFiled] = isSynced;
    data[updatedAtFiled] = updatedAt;
    data[createdAtFiled] = createdAt;
    return data;
  }
}
