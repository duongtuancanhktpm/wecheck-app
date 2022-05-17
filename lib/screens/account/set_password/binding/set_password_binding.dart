

import 'package:get/get.dart';
import 'package:wecheck/screens/account/set_password/controller/set_password_controller.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetPasswordController());
  }

}