

import 'package:get/get.dart';
import 'package:wecheck/screens/account/sign_in/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }

}