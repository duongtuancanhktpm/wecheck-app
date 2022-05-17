import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends GetView {

  PrivacyPolicyScreen({Key? key, required this.onTapNext}) : super(key: key);

  @override
  late PrivacyPolicyController controller;

  late Function onTapNext;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(PrivacyPolicyController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50),
                  child: Text(
                    L.current.privacyPolicy.tr,
                    style: const TextStyle(
                        color: AppColors.textRegalBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  child: Container(
                    width: double.infinity,
                    height: 430.h,
                    child: const WebView(
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
          ],
        ),
      ),
    );
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
                    color: AppColors.colorDarkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Obx(() => InkWell(
                    onTap: () =>
                        {if (controller.isAgreePolicy.value) onTapNext()},
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        L.current.next,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                        color: controller.isAgreePolicy.value
                            ? AppColors.colorCeruleanBlue
                            : AppColors.colorHawkesBlue,
                        border: Border.all(
                            color: controller.isAgreePolicy.value
                                ? AppColors.colorCeruleanBlue
                                : AppColors.colorHawkesBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
