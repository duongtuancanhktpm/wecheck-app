
import 'package:get/get.dart';
import 'package:wecheck/repository/set_password_repository.dart';
import 'package:wecheck/routes/routes.dart';

class SetPasswordController extends GetxController {

  var hidePassword = true.obs;
  var isActiveResetPassword = false.obs;

  var passwordText = ''.obs;
  var setPasswordRepository = SetPasswordRepository();

  void backToSignIn() {
    Get.back();
  }

  void goToCreateProfile() {
    if (isActiveResetPassword.value) {
      // Get.toNamed(RouteName.createProfile);
    }
  }

}