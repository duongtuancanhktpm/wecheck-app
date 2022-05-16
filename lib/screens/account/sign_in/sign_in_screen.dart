import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/sign_in/controller/sign_in_controller.dart';
import 'package:wecheck/theme/colors.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    inputEmailWidget(),
                    inputPasswordWidget(),
                    rememberMyIDWidget(),
                  ],
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 50, right: 50),
                          child: bottomSignInButton(),
                        )))
              ],
            )));
  }

  Widget bottomSignInButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding:
            const EdgeInsets.only(top: 20, bottom: 10),
            child: Obx(() =>
                InkWell(
                  onTap: () => controller.goToHome(),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12),
                    child: Text(
                      L.current.signIn,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    decoration: BoxDecoration(
                      color: controller.isActiveLogin.value
                          ? AppColors.colorBlueLabel
                          : AppColors.colorDisable,
                      border: Border.all(
                          color:
                          controller.isActiveLogin.value
                              ? AppColors.colorBlueLabel
                              : AppColors.colorDisable),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(15.0)),
                    ),
                  ),
                ))),
        InkWell(
          onTap: () => controller.goToResetPassword(),
          child: Container(
            padding:
            const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              L.current.forgotPassword,
              style: const TextStyle(
                  color: AppColors.colorBlueLabel,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
            padding:
            const EdgeInsets.only(top: 20, bottom: 20),
            child: InkWell(
              onTap: () => controller.goToCreateAccount(),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                      color: AppColors.colorBlueLabel,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: Colors.blueAccent),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(15.0)),
                ),
              ),
            ))
      ],
    );
  }

  Widget inputEmailWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
        onChanged: (value) {
          if (value.isNotEmpty) {
            controller.isActiveLogin.value = true;
          } else {
            controller.isActiveLogin.value = false;
          }
        },
      ),
    );
  }

  Widget inputPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Obx(
            () =>
            TextFormField(
              onChanged: (value) {
                //print(value);
              },
              obscureText: controller.hidePassword.value,
              //show/hide password
              decoration: InputDecoration(
                  fillColor: AppColors.white,
                  suffixIcon: IconButton(
                      icon: controller.hidePassword.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        controller.hidePassword.value =
                        !controller.hidePassword.value;
                      }),
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
                  labelText: L.current.password.tr,
                  labelStyle: const TextStyle(
                      color: AppColors.colorTextSignIn,
                      fontWeight: FontWeight.bold)),
            ),
      ),
    );
  }

  Widget rememberMyIDWidget() {
    return Padding(
        padding:
        const EdgeInsets.only(top: 10, left: 35, right: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() =>
                Checkbox(
                    value: controller.isRememberId.value,
                    onChanged: (value) =>
                    controller.isRememberId.value = value!)),
            Text(
              L.current.rememberMyID.tr,
              style: const TextStyle(
                  color: AppColors.colorTextSignIn,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        ));
  }
}
