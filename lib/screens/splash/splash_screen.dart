import 'package:wecheck/screens/splash/controller/splash_controller.dart';
import 'package:wecheck/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.initController = true;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text("Splash", style: AppTextStyle.t18w700()),
      ),
    );
  }
}
