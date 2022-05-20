import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/input_code/controller/input_code_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/text_styles.dart';

class InputCodeScreen extends GetView {

  @override
  late InputCodeController controller;
  late Function onTapNext;

  InputCodeScreen({Key? key,  required this.onTapNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(InputCodeController());

    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  L.current.verifyEmailAddress,
                  style: AppTextStyle.t20w700(AppColors.textRegalBlue)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Text(
                  L.current.verifyCode,
                  style: AppTextStyle.t14w700(AppColors.colorGrey),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 250.dp,
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
                        autoFocus: true,
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
                            fieldHeight: 50.dp,
                            fieldWidth: 40.dp,
                            borderWidth: 1,
                            activeFillColor: Colors.white,
                            inactiveColor: AppColors.colorGrey,
                            inactiveFillColor: AppColors.white,
                            selectedColor: AppColors.white,
                            selectedFillColor: AppColors.white,
                            activeColor: Colors.white),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {},
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
                             onTap: () {
                               onTapNext();
                             },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Text(
                                  L.current.verify,
                                  style: AppTextStyle.t16w700(AppColors.white),
                                ),
                                decoration: BoxDecoration(
                                  color: controller.isActiveVerify.value
                                      ? AppColors.colorCeruleanBlue
                                      : AppColors.colorHawkesBlue,
                                  border: Border.all(
                                      color: controller.isActiveVerify.value
                                          ? AppColors.colorCeruleanBlue
                                          : AppColors.colorHawkesBlue),
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
