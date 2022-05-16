import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wecheck/utils/widget/back_skip_sign_in.dart';

import '../../../utils/widget/indicator_sign_in.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backSignInButton(()=> controller.backToSignIn()),
              indicatorSignIn(
                  AppColors.colorBlueLabel,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50),
                child: Text(
                  L.current.privacyPolicy.tr,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                child: const SizedBox(
                  width: double.infinity,
                  height: 430,
                  child: WebView(
                    initialUrl: 'https://flutter.dev',
                  ),
                ),
                padding: const EdgeInsets.all(20),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buttonNext(),
            ),
          )
        ])));
  }

  Widget buttonNext() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => Checkbox(
                  value: controller.isAgreePolicy.value,
                  onChanged: (value) {
                    controller.isAgreePolicy.value = value!;
                  })),
              const Text(
                'I have read and agreed the privacy policy',
                style: TextStyle(
                    color: AppColors.colorTextSignIn,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Obx(() => InkWell(
                onTap: () => controller.goToCreateAccount(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                  const EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    L.current.next,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                    color: controller.isAgreePolicy.value
                        ? AppColors.colorBlueLabel
                        : AppColors.colorDisable,
                    border: Border.all(
                        color: controller.isAgreePolicy.value
                            ? AppColors.colorBlueLabel
                            : AppColors.colorDisable),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15.0)),
                  ),
                ),
              ))),
        ],
      ),
    );
  }
}
