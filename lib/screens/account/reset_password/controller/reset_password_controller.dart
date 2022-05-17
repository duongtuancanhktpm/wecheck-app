
import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class ResetPasswordController extends GetxController {

  var hidePassword = true.obs;
  var isActiveResetPassword = false.obs;

  void backToSignIn() {
    Get.back();
  }

}