

import 'package:get/get.dart';
import 'package:wecheck/screens/account/input_code/controller/input_code_controller.dart';
import 'package:wecheck/screens/account/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:wecheck/screens/account/reset_password/controller/reset_password_controller.dart';

class InputCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputCodeController());
  }

}