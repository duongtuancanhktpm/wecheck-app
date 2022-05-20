import 'package:get/get.dart';
import 'package:wecheck/screens/settings_profile/controller/settings_profile_controller.dart';

class SettingsProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsProfileController());
  }

}