import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/reset_password/controller/reset_password_controller.dart';
import 'package:wecheck/theme/colors.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.only(top: 80, left: 50),
                  child: Text(
                    L.current.resetPassword.tr,
                    style: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
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
                          floatingLabelStyle: const TextStyle(
                              height: 0.2,
                              color: AppColors.colorBlueLabel,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.colorTextSignIn),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: AppColors.colorTextSignIn,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(alignment: Alignment.bottomCenter,child: Container(padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding:
                      const EdgeInsets.only(top: 20, bottom: 10),
                      child: Obx(() => InkWell(
                        onTap: () => controller.backToSignIn(),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12),
                          child: Text(
                              L.current.resetPassword.tr,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          decoration: BoxDecoration(
                            color: controller.isActiveResetPassword.value
                                ? AppColors.colorBlueLabel
                                : AppColors.colorDisable,
                            border: Border.all(
                                color:
                                controller.isActiveResetPassword.value
                                    ? AppColors.colorBlueLabel
                                    : AppColors.colorDisable),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(15.0)),
                          ),
                        ),
                      ))),
                ],
              ),),),
            )
          ],
        )));
  }
}
