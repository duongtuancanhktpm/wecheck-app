
import 'package:get/get.dart';
import 'package:wecheck/repository/input_code_repository.dart';

class InputCodeController extends GetxController {
  // late Rx<TextEditingController> textEditingController;
  // late Rx<StreamController<ErrorAnimationType>> errorController;
  Rx<String> pinCodeText = "".obs;
  Rx<bool> isActiveVerify = false.obs;

  var inputCodeRepository = InputCodeRepository();

  @override
  void onInit() {
    // errorController = StreamController<ErrorAnimationType>().obs;
    // textEditingController = TextEditingController().obs;
    super.onInit();
  }

  void backToSignIn() {
    Get.back();
  }

}
