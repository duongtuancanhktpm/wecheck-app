import 'package:get/get.dart';
import 'package:wecheck/repository/input_email_repository.dart';
import 'package:wecheck/routes/routes.dart';

class InputEmailController extends GetxController {
  RxBool isActiveSendEmail = false.obs;
  RxString emailInput = ''.obs;
  var  inputEmailRepository = InputEmailRepository();



  void goToResetPassword() {
    Get.toNamed(RouteName.resetPassword);
  }

}
