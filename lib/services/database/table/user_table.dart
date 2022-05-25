import 'package:floor/floor.dart';
import 'package:wecheck/utils/extensions.dart';

@Entity(tableName: "user", primaryKeys: ["id"])
class UserTable {
  static const String tableName = "user";
  @primaryKey
  String? id;
  static const String idField = "id";

  String? firstName;
  static const String firstNameField = "first_name";

  String? lastName;
  static const String lastNameField = "last_name";

  String? birthDay;
  static const String birthDayField = "birth_day";

  int? sex;
  static const String sexField = "sex";

  String? country;
  static const String countryField = "country";

  double? heigh;
  static const String heighField = "heigh";

  double? weight;
  static const String weightField = "weight";

  String? phone;
  static const String phoneField = "phone";

  String? email;
  static const String emailField = "email";

  String? syncedTime;
  static const String syncedTimeField = "synced_time";

  String? image;
  static const String imageField = "image";

  String? diabete;
  static const String diabeteField = "diabete";

  int? isSynced;
  static const String isSyncedField = "is_synced";

  String? updatedAt;
  static const String updatedAtField = "updated_at";

  String? createdAt;
  static const String createdAtField = "created_at";

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
    String? email,
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
    this.email = email;
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
    firstName = data[firstNameField]?.toString();
    lastName = data[lastNameField]?.toString();
    birthDay = data[birthDayField]?.toString();
    sex = data[sexField]?.toString().toInt();
    country = data[countryField]?.toString();
    heigh = double.parse(data[heighField]?.toString() ?? "-1");
    weight = double.parse(data[weightField]?.toString() ?? "-1");
    phone = data[phoneField]?.toString();
    email = data[emailField]?.toString();
    syncedTime = data[syncedTimeField]?.toString();
    image = data[imageField]?.toString();
    diabete = data[diabeteField]?.toString();
    isSynced = data[isSyncedField].toString().toInt();
    updatedAt = data[updatedAtField]?.toString();
    createdAt = data[createdAtField]?.toString();
  }

  @ignore
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data[idField] = id;
    data[firstNameField] = firstName;
    data[lastNameField] = lastNameField;
    data[birthDayField] = birthDay;
    data[sexField] = sex;
    data[countryField] = country;
    data[heighField] = heigh;
    data[weightField] = weight;
    data[phoneField] = phone;
    data[emailField] = email;
    data[syncedTimeField] = syncedTime;
    data[imageField] = image;
    data[diabeteField] = diabete;
    data[isSyncedField] = isSynced;
    data[updatedAtField] = updatedAt;
    data[createdAtField] = createdAt;
    return data;
  }
}
