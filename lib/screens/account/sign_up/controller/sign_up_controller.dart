import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/routes/routes.dart';

class SignUpController extends GetxController {
  RxInt currentPosition = 0.obs;
  late PageController pagerController;

  @override
  void onInit() {
    currentPosition.value = 0;
    pagerController = PageController(initialPage: currentPosition.value);
    super.onInit();
  }

  void backToSignIn() {
    Get.back();
  }

  void goToHome() {
    Get.offAndToNamed(RouteName.root);
  }

}
