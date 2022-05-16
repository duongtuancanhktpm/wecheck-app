import 'package:get/get.dart';

import 'package:wecheck/screens/setting/controller/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}