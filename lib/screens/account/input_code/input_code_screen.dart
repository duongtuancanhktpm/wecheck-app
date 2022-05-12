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
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 50),
                child: Text(
                  'Input Code',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 300,
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
                          errorAnimationController: controller.errorController.value,
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
              const Padding(padding: EdgeInsets.all(25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppColors.colorBtnSignIn,
                                  AppColors.colorBtnSignIn,
                                  AppColors.colorBtnSignIn
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 10, bottom: 10),
                            primary: AppColors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () => controller.goToCreateAccount(),
                          child: Text(L.current.next,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => controller.goToResetPassword(),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, top: 10, right: 20),
                        child: Text(
                          L.current.resetPassword,
                          style: const TextStyle(
                              color: AppColors.colorBottomSignIn,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.goToCreateAccount(),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, top: 10, right: 20),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                              color: AppColors.colorBottomSignIn,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ])));
  }
}
