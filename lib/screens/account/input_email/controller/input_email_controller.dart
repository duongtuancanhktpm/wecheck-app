import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class InputEmailController extends GetxController {
  RxBool isActiveSendEmail = false.obs;

  void backToSignIn() {
    Get.back();
  }

  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }

}
