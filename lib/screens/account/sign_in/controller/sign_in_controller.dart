


import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class SignInController extends GetxController {

  var hidePassword = true.obs;


  void goToCreateAccount(){
   // Get.toNamed(RouteName.signUp);
    Get.toNamed(RouteName.privacyPolicy);
  }
  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }

  void goToHome() {
    Get.toNamed(RouteName.home);
  }
}