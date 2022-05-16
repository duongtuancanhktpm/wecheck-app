import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/sign_up/controller/sign_up_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/utils/widget/back_skip_sign_in.dart';
import 'package:wecheck/utils/widget/indicator_sign_in.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backSignInButton(()=> controller.backToSignIn()),
              indicatorSignIn(
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn),
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 50),
                child: Text(
                  L.current.signIn.tr,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
                child: TextFormField(
                  onChanged: (value) {
                    controller.isActiveSendEmail.value = true;
                  },
                  decoration: InputDecoration(
                      fillColor: AppColors.white,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.colorTextSignIn),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.colorTextSignIn),
                      ),
                      floatingLabelStyle: const TextStyle(
                          height: 0.2,
                          color: AppColors.colorBlueLabel,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      labelText: L.current.email.tr,
                      labelStyle: const TextStyle(
                          color: AppColors.colorTextSignIn,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Obx(() => InkWell(
                              onTap: () => controller.goToInputCode(),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Text(
                                  L.current.sendEmail.tr,
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                decoration: BoxDecoration(
                                  color: controller.isActiveSendEmail.value
                                      ? AppColors.colorBlueLabel
                                      : AppColors.colorDisable,
                                  border: Border.all(
                                      color: controller.isActiveSendEmail.value
                                          ? AppColors.colorBlueLabel
                                          : AppColors.colorDisable),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
