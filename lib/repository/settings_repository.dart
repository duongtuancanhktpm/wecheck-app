import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/services/database/dao/user_table_dao.dart';
import 'package:wecheck/services/database/table/user_table.dart';
import 'package:wecheck/theme/images.dart';
import 'package:wecheck/utils/database_helper.dart';

class SettingsRepository {
  Future<UserProfile> doGetUserProfile() {
    return Future.value(
        UserProfile(AppImages.defaultImage, "My name", "email@email.com"));
  }

  Future<SettingsData> doGetSettingsData() async{
    DatabaseHelper dbHelper = DatabaseHelper();
    UserTableDao userTableDao = dbHelper.userTableDao;
    UserTable? user = await userTableDao.getUserTableById("2");
    return Future.value(SettingsData(user!));
  }
}
