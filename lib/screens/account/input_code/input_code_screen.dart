import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/input_code/controller/input_code_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
              InkWell(
                onTap: () => controller.backToSignIn(),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.colorBlueLabel,
                      ),
                      Text(
                        L.current.back,
                        style: const TextStyle(
                            color: AppColors.colorBlueLabel,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
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
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        obscuringWidget: const FlutterLogo(
                          size: 24,
                        ),
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
                          activeFillColor: Colors.white,
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
                          debugPrint("Completed");
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
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
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
                              onTap: () => controller.goToCreateProfile(),
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
