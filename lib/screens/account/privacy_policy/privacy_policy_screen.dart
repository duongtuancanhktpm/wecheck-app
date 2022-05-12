import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/account/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 50),
                child: Text(
                  L.current.privacyPolicy.tr,
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 300,
                child: WebView(
                  initialUrl: 'https://flutter.dev',
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 35, right: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text(
                        'I have read and agreed the privacy policy',
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
