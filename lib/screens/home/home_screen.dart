import 'package:wecheck/screens/home/controller/home_controller.dart';
import 'package:wecheck/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  String screenName;

  HomeScreen({Key? key, required this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Center(
            child: Text(screenName, style: AppTextStyle.t18w700()),
          ),
        ),
      ),
    );
  }
}
