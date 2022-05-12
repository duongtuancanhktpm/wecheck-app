import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class SignUpController extends GetxController {
  void backToSignIn() {
    Get.back();
  }

  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }
  void goToInputCode() {
    Get.toNamed(RouteName.inputCode);
  }
}
