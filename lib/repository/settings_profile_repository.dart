import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/model/settings_profile_data.dart';
import 'package:wecheck/services/database/dao/user_table_dao.dart';
import 'package:wecheck/services/database/table/user_table.dart';
import 'package:wecheck/theme/images.dart';
import 'package:wecheck/utils/database_helper.dart';

class SettingsProfileRepository {
  DatabaseHelper dbHelper = DatabaseHelper();


  Future<SettingsProfileData> doGetSettingsProfileData() async {
    UserTableDao userTableDao = dbHelper.userTableDao;
    UserTable? user = UserTable(id: "1", firstName: "loading", lastName: "...");
    user = await userTableDao.getUserTableById("1");
    return Future.value(
      SettingsProfileData(
        Profile(AppImages.defaultImage, "Geted name", "geted email"),
        user!,
      ),
    );
  }
}
