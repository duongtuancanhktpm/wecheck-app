import 'package:get/get.dart';
import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/repository/settings_repository.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/theme/images.dart';

class SettingsController extends GetxController {
  var settingsRepository = SettingsRepository();
  var userProfile = UserProfile(AppImages.defaultImage, "name", "abc@imail.com").obs;

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