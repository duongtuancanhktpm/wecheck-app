import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/text_styles.dart';

import 'controller/set_password_controller.dart';

class SetPasswordScreen extends GetView {
  @override
  late SetPasswordController controller;

  late Function onTapNext;

  SetPasswordScreen({Key? key,  required this.onTapNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SetPasswordController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50),
                  child: Text(
                    L.current.setPassword.tr,
                    style: AppTextStyle.t20w700(AppColors.textRegalBlue),
                  ),
                ),
                inputPasswordWidget(),
                inputConfirmPasswordWidget()
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [passwordButton()],
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Widget passwordButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Obx(() => InkWell(
              onTap: () =>
                  {if (controller.isActiveResetPassword.value) onTapNext()},
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  L.current.next.tr,
                  style: AppTextStyle.t16w700(AppColors.white),
                ),
                decoration: BoxDecoration(
                  color: controller.isActiveResetPassword.value
                      ? AppColors.colorCeruleanBlue
                      : AppColors.colorHawkesBlue,
                  border: Border.all(
                      color: controller.isActiveResetPassword.value
                          ? AppColors.colorCeruleanBlue
                          : AppColors.colorHawkesBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            )));
  }

  inputPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
      child: Obx(
        () => TextFormField(
          onChanged: (value) {
            controller.isActiveResetPassword.value = true;
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
              floatingLabelStyle: AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorDarkGrey),
              ),
              labelText: L.current.password.tr,
              labelStyle: AppTextStyle.t16w700(AppColors.colorDarkGrey)),
        ),
      ),
    );
  }

  Widget inputConfirmPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
      child: Obx(
        () => TextFormField(
          onChanged: (value) {
            controller.isActiveResetPassword.value = true;
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
              floatingLabelStyle: AppTextStyle.t20w700(AppColors.colorCeruleanBlue, 0.2),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorDarkGrey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorDarkGrey),
              ),
              labelText: L.current.confirmPassword.tr,
              labelStyle: AppTextStyle.t16w700(AppColors.colorDarkGrey)),
        ),
      ),
    );
  }
}
