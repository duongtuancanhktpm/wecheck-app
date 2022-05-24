import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/sign_in/controller/sign_in_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

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
                    style: AppTextStyle.t20w700(AppColors.textRegalBlue),
                  ),
                ),
                _inputEmailWidget(),
                _inputPasswordWidget(),
                _rememberMyIDWidget(),
              ],
            ),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: _bottomSignInButton(),
                    )))
          ],
        )));
  }

  Widget _bottomSignInButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Obx(() => InkWell(
                  onTap: () => controller.callLoginService(),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      L.current.signIn,
                      style: AppTextStyle.t16w700(AppColors.white),
                    ),
                    decoration: BoxDecoration(
                      color: controller.isActiveLogin.value
                          ? AppColors.colorCeruleanBlue
                          : AppColors.colorHawkesBlue,
                      border: Border.all(
                          color: controller.isActiveLogin.value
                              ? AppColors.colorCeruleanBlue
                              : AppColors.colorHawkesBlue),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ))),
        InkWell(
          onTap: () => controller.goToResetPassword(),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              L.current.forgetPassword,
              style: AppTextStyle.t14w700(AppColors.colorCeruleanBlue),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: InkWell(
              onTap: () => controller.goToCreateAccount(),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  L.current.createAccount.tr,
                  style: AppTextStyle.t16w700(AppColors.colorCeruleanBlue),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ))
      ],
    );
  }

  Widget _inputEmailWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: AppColors.white,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.colorDarkGrey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.colorDarkGrey),
            ),
            floatingLabelStyle:
                AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
            labelText: L.current.email.tr,
            labelStyle: AppTextStyle.t16w700(AppColors.colorDarkGrey)),
        onChanged: (value) {
          if (value.isNotEmpty) {
            controller.usernameInput.value = value;
            controller.isActiveLogin.value = true;
          } else {
            controller.isActiveLogin.value = false;
          }
        },
      ),
    );
  }

  Widget _inputPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Obx(
        () => TextFormField(
          onChanged: (value) {
            controller.passwordInput.value = value;
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
                borderSide: BorderSide(color: AppColors.colorDarkGrey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorDarkGrey),
              ),
              floatingLabelStyle:
                  AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
              labelText: L.current.password.tr,
              labelStyle: AppTextStyle.t14w700(AppColors.colorDarkGrey)),
        ),
      ),
    );
  }

  Widget _rememberMyIDWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 35, right: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => Checkbox(
                value: controller.isRememberId.value,
                onChanged: (value) => controller.isRememberId.value = value!)),
            Text(
              L.current.rememberMyID.tr,
              style: AppTextStyle.t14w700(AppColors.colorDarkGrey),
            )
          ],
        ));
  }
}
