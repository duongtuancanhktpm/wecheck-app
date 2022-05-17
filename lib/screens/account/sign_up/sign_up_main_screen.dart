import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/input_code/input_code_screen.dart';
import 'package:wecheck/screens/account/input_email/input_email_screen.dart';
import 'package:wecheck/screens/account/privacy_policy/privacy_policy_screen.dart';
import 'package:wecheck/screens/account/set_password/set_password_screen.dart';
import 'package:wecheck/screens/account/sign_up/controller/sign_up_controller.dart';
import 'package:wecheck/screens/profile/create/create_profile_screen.dart';
import 'package:wecheck/screens/profile/diabetes/diabetes_screen.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/widgets/indicator_sign_in.dart';

class SignUpMainScreen extends GetView<SignUpController> {
  const SignUpMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _clickBackButton(),
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10, right: 10),
                        child: controller.currentPosition.value == 0
                            ? Text(
                                L.current.cancel.tr,
                                style: const TextStyle(
                                    color: AppColors.colorCeruleanBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.colorCeruleanBlue,
                                  ),
                                  Text(
                                    L.current.back.tr,
                                    style: const TextStyle(
                                        color: AppColors.colorCeruleanBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      )),
                ),
              ],
            ),
            actions: [
              Obx(() => controller.currentPosition.value > 3
                  ? InkWell(
                      onTap: () => controller.goToHome(),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              L.current.skip.tr,
                              style: const TextStyle(
                                  color: AppColors.colorCeruleanBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container())
            ],
          ),
          body: signUpMainLayout(),
        ),
        onWillPop: ()=> _clickBackButton());
  }

  Widget signUpMainLayout() {
    var listScreen = <Widget>[
      PrivacyPolicyScreen(() => {controller.pagerController.jumpToPage(1)}),
      InputEmailScreen(() => {controller.pagerController.jumpToPage(2)}),
      InputCodeScreen(() => {controller.pagerController.jumpToPage(3)}),
      SetPasswordScreen(() => {controller.pagerController.jumpToPage(4)}),
      CreateProfileScreen(() => {controller.pagerController.jumpToPage(5)}),
      DiabetesScreen(() => {controller.goToHome()})
    ];
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(() => indicatorSignIn(
                listScreen.length, controller.currentPosition.value)),
            Expanded(
                child: PageView(
              controller: controller.pagerController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                controller.currentPosition.value = value;
              },
              children: listScreen,
            ))
          ],
        ),
      ],
    );
  }

  _clickBackButton() {
    if (controller.currentPosition.value == 0) {
      Get.back();
    } else {
      int pos = controller.currentPosition.value - 1;
      controller.pagerController.jumpToPage(pos);
    }
  }
}
