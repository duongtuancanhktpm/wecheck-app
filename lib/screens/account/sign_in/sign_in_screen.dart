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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 50, right: 50),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            fillColor: AppColors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.colorTextSignIn),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.colorTextSignIn),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: AppColors.colorTextSignIn,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 50, right: 50),
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
                                    BorderSide(
                                        color: AppColors.colorTextSignIn),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: AppColors.colorTextSignIn),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                      color: AppColors.colorTextSignIn,
                                      fontWeight: FontWeight.bold)),
                            ),
                      ),
                    ),
                    Padding(
                        padding:
                        const EdgeInsets.only(top: 10, left: 35, right: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            const Text(
                              'Remember my ID',
                              style: TextStyle(
                                  color: AppColors.colorTextSignIn,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        )),
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
                                      left: 30.0,
                                      right: 30,
                                      top: 10,
                                      bottom: 10),
                                  primary: AppColors.white,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {},
                                child: const Text('Sign In'),
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
                            onTap: () {

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10, right: 20),
                              child: const Text(
                                "Reset Password", style: TextStyle(
                                  color: AppColors.colorBottomSignIn,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ), InkWell(
                            onTap: () {
                              controller.goToCreateAccount();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10, right: 20),
                              child: const Text(
                                "Create Account", style: TextStyle(
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
