import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class SignInController extends GetxController {
  var hidePassword = true.obs;
  RxBool isRememberId = false.obs;
  RxBool isActiveLogin = false.obs;

  void goToCreateAccount() {
    //Get.toNamed(RouteName.privacyPolicy);
    Get.toNamed(RouteName.signUpMain);
  }

  void backToSignIn() {
    Get.back();
  }

  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }

  void goToHome() {
    if (isActiveLogin.value) {
      Get.toNamed(RouteName.root);
    }
    // Get.toNamed(RouteName.createProfile);
  }
}
