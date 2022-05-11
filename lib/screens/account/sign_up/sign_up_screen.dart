import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/sign_up/controller/sign_up_controller.dart';
import 'package:wecheck/theme/colors.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
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
                          child: const Text('Send Email'),
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, top: 10, right: 20),
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                              color: AppColors.colorBottomSignIn,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
      )),
    );
  }
}
