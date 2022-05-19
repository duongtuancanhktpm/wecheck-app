import 'package:get/get.dart';
import 'package:wecheck/screens/settings/controller/setting_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}