import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/input_code/controller/input_code_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wecheck/utils/widget/back_skip_sign_in.dart';
import 'package:wecheck/utils/widget/indicator_sign_in.dart';

class InputCodeScreen extends GetView<InputCodeController> {
  const InputCodeScreen({Key? key}) : super(key: key);

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
                  AppColors.colorBlueLabel,
                  AppColors.colorBlueLabel,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn,
                  AppColors.colorBottomSignIn),
              Padding(
                padding: EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  L.current.verifyEmailAddress,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text(
                  L.current.verifyCode,
                  style: const TextStyle(
                      color: AppColors.colorBottomSignIn,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Form(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 80.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        //obscureText: true,
                        // obscuringCharacter: '*',
                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          borderWidth: 1,
                          activeFillColor: Colors.white,
                          inactiveColor: AppColors.colorBottomSignIn,
                          inactiveFillColor: AppColors.white,
                          selectedColor: AppColors.white,
                          selectedFillColor: AppColors.white,
                          activeColor: Colors.white
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController:
                            controller.errorController.value,
                        controller: controller.textEditingController.value,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {

                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          controller.currentText.value = value;
                          if (value.length == 6) {
                            controller.isActiveVerify.value = true;
                          } else {
                            controller.isActiveVerify.value = false;
                          }
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
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
                              onTap: () => controller.goToSetPassword(),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Text(
                                  L.current.verify,
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                decoration: BoxDecoration(
                                  color: controller.isActiveVerify.value
                                      ? AppColors.colorBlueLabel
                                      : AppColors.colorDisable,
                                  border: Border.all(
                                      color: controller.isActiveVerify.value
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
        ])));
  }
}
