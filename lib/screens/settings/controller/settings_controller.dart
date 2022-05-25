import 'package:get/get.dart';
import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/repository/settings_repository.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/services/database/dao/user_table_dao.dart';
import 'package:wecheck/services/database/table/user_table.dart';
import 'package:wecheck/theme/images.dart';
import 'package:wecheck/utils/database_helper.dart';

class SettingsController extends GetxController {
  var settingsRepository = SettingsRepository();
  var userProfile =
      UserProfile(AppImages.defaultImage, "name", "abc@imail.com").obs;
  var profile = UserTable().obs;

  @override
  void onInit() {
    settingsRepository.doGetUserProfile().then((value) {
      userProfile.value = value;
    });
    settingsRepository
        .doGetSettingsData()
        .then((value) => profile.value = value.userProfile);
    super.onInit();
  }

  void gotoSettingsProfile() {
    Get.toNamed(RouteName.settingsProfile);
  }

  void goto(String name) {
    ///those (insertDefaultUser() and delete()) are to test, need to del after test done
    ///insertDefaultUser();
    ///delete();
    Get.toNamed(name);
  }

  ///this function is for testing, need to del lately
  void dropDb() {
    DatabaseHelper dbHelper = DatabaseHelper();
    dbHelper.dropDB();
  }

  ///this function is for testing, need to del lately
  void delete() {
    print("canhdt1 delete all");
    DatabaseHelper dbHelper = DatabaseHelper();
    UserTableDao userTableDao = dbHelper.userTableDao;
    userTableDao.deleteAllRows();
  }

  ///this function is for testing, need to del lately
  void insertDefaultUser() {
    print("canhdt1 instert default");
    DatabaseHelper dbHelper = DatabaseHelper();
    UserTableDao userTableDao = dbHelper.userTableDao;
    userTableDao.insert([
      UserTable(
          id: "1",
          firstName: "first",
          lastName: "last",
          birthDay: "birth day",
          sex: 0,
          country: "dong lao",
          heigh: 111,
          weight: 111,
          phone: "phone",
          syncedTime: "time",
          image: "image",
          diabete: "nes",
          isSynced: 0,
          updatedAt: "string",
          createdAt: "string"),
      UserTable(
          id: "2",
          firstName: "first 2",
          lastName: "last 2",
          birthDay: "birth day",
          sex: 0,
          country: "dong lao",
          heigh: 111,
          weight: 111,
          phone: "phone",
          syncedTime: "time",
          image: "image",
          diabete: "nes",
          isSynced: 0,
          updatedAt: "string",
          createdAt: "string"),
    ]);
  }
}
