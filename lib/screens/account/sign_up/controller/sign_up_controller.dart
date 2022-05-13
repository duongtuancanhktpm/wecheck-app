import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class SignUpController extends GetxController {
  RxBool isActiveSendEmail = false.obs;

  void backToSignIn() {
    Get.back();
  }

  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }

  void goToInputCode() {
    if (isActiveSendEmail.value) {
      Get.toNamed(RouteName.inputCode);
    }
  }
}
