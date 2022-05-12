
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wecheck/routes/routes.dart';

class InputCodeController extends GetxController {
  Rx<TextEditingController> textEditingController = TextEditingController().obs;
  late Rx<StreamController<ErrorAnimationType>> errorController;
  Rx<String> currentText = "".obs;

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>().obs;
    super.onInit();
  }

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