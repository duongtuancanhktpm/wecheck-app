

import 'package:get/get.dart';
import 'package:wecheck/screens/account/sign_up/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }

}