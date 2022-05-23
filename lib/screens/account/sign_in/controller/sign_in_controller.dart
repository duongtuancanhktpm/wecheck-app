import 'package:get/get.dart';
import 'package:wecheck/repository/sign_in_respository.dart';
import 'package:wecheck/routes/routes.dart';

class SignInController extends GetxController {
  var hidePassword = true.obs;
  RxBool isRememberId = false.obs;
  RxBool isActiveLogin = false.obs;

  var usernameInput = ''.obs;
  var passwordInput = ''.obs;

  var signInRepository = SignInRepository();

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

  void callLoginService() {
    signInRepository
        .callLogin(usernameInput.value, passwordInput.value)
        .then((value) {
              Get.offAndToNamed(RouteName.root);
            });
  }
}
