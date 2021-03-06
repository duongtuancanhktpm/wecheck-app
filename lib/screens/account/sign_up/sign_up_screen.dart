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
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/widgets/indicator_sign_in.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: _appBarSignUp(),
          body: signUpMainLayout(),
        ),
        onWillPop: () => _clickBackButton());
  }

  Widget signUpMainLayout() {
    var listScreen = <Widget>[
      PrivacyPolicyScreen(
          onTapNext: () => {controller.pagerController.jumpToPage(1)}),
      InputEmailScreen(
          onTapNext: () => {controller.pagerController.jumpToPage(2)}),
      InputCodeScreen(
          onTapNext: () => {controller.pagerController.jumpToPage(3)}),
      SetPasswordScreen(
          onTapNext: () => {controller.pagerController.jumpToPage(4)}),
      CreateProfileScreen(
          onTapNext: () => {controller.pagerController.jumpToPage(5)}),
      DiabetesScreen(onTapNext: () => {controller.goToHome()})
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

  _appBarSignUp() {
    return AppBar(
      leadingWidth: 100,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => InkWell(
              onTap: () => _clickBackButton(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 10, right: 10),
                child: controller.currentPosition.value == 0
                    ? Text(
                        L.current.cancel.tr,
                        style:
                            AppTextStyle.t16w700(AppColors.colorCeruleanBlue),
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
                            style: AppTextStyle.t16w700(
                                AppColors.colorCeruleanBlue),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Obx(() => controller.currentPosition.value > 3
            ? InkWell(
                onTap: () => controller.goToHome(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 20, left: 10),
                  child: Center(
                    child: Text(
                      L.current.skip.tr,
                      style: AppTextStyle.t16w700(AppColors.colorCeruleanBlue),
                    ),
                  ),
                ),
              )
            : Container())
      ],
    );
  }
}
