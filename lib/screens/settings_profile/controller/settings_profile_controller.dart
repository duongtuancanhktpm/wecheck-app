import 'package:get/get.dart';
import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/repository/settings_profile_repository.dart';
import 'package:wecheck/services/database/table/user_table.dart';
import 'package:wecheck/theme/images.dart';


class SettingsProfileController extends GetxController {
  var data = Profile(AppImages.defaultImage, "loading", "abc.imail.com").obs;
  var repository = SettingsProfileRepository();
  var userProfile = UserTable().obs;
  @override
  void onInit() {
    repository.doGetSettingsProfileData().then((value) {
      data.value = value.profile;
      userProfile.value = value.userTable;
    });
    super.onInit();
  }

  void goto(String path) {
    Get.toNamed(path);
  }


}
