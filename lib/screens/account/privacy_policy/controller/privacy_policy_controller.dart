
import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class PrivacyPolicyController extends GetxController {

  void backToSignIn() {
    Get.back();
  }

  void goToCreateAccount() {
    Get.toNamed(RouteName.signUp);
  }
  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }
}