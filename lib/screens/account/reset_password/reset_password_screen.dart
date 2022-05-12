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
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: AppColors.colorTextSignIn,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
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
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {},
                            child: Text(L.current.resetPassword.tr, style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => controller.backToSignIn(),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 10, top: 10, right: 20),
                          child: const Text(
                            "Back to sign in",
                            style: TextStyle(
                                color: AppColors.colorBottomSignIn,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        )));
  }
}
