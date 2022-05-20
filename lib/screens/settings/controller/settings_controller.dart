import 'package:get/get.dart';
import 'package:wecheck/model/user_profile_data.dart';
import 'package:wecheck/repository/settings_repository.dart';
import 'package:wecheck/routes/routes.dart';

class SettingsController extends GetxController {
  var settingsRepository = SettingsRepository();
  var userProfile = UserProfile("default", "", "").obs;

  @override
  void onInit() {
    settingsRepository.doGetUserProfile().then((value) {
      userProfile.value = value;
    });
    super.onInit();
  }

  void gotoSettingsProfile(){
    Get.toNamed(RouteName.settingsProfile);
  }
  void goto(String name){
    Get.toNamed(name);
  }
}