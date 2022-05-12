import 'package:wecheck/screens/account/privacy_policy/binding/privacy_policy_binding.dart';
import 'package:wecheck/screens/account/privacy_policy/privacy_policy_screen.dart';
import 'package:wecheck/screens/account/reset_password/binding/reset_password_binding.dart';
import 'package:wecheck/screens/account/reset_password/reset_password_screen.dart';
import 'package:wecheck/screens/account/sign_up/binding/sign_up_binding.dart';
import 'package:wecheck/screens/account/sign_up/sign_up_screen.dart';
import 'package:wecheck/screens/root/binding/root_binding.dart';
import 'package:wecheck/screens/root/root_screen.dart';
import 'package:wecheck/screens/account/sign_in/binding/sign_in_binding.dart';
import 'package:wecheck/screens/account/sign_in/sign_in_screen.dart';
import 'package:wecheck/screens/splash/bindings/splash_binding.dart';
import 'package:wecheck/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteName {
  static const String splash = "/splash";
  static const String root = "/root";
  static const String home = "/home";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String resetPassword = "/resetPassword";
  static const String privacyPolicy= "/privacyPolicy";
}

class AppRoutes {
  static final screens = <String, Widget Function()>{
    RouteName.splash: () => SplashScreen(),
    RouteName.root: () => const RootScreen(),
    RouteName.signIn: () => const SignInScreen(),
    RouteName.signUp: () => const SignUpScreen(),
    RouteName.resetPassword: () => const ResetPasswordScreen(),
    RouteName.privacyPolicy: () => const PrivacyPolicyScreen(),
  };

  static final bindings = <String, List<Bindings> Function()>{
    RouteName.splash: () => [SplashBinding()],
    RouteName.root: () => [RootBinding()],
    RouteName.signIn: () => [SignInBinding()],
    RouteName.signUp: () => [SignUpBinding()],
    RouteName.resetPassword: () => [ResetPasswordBinding()],
    RouteName.privacyPolicy: () => [PrivacyPolicyBinding()],
  };

  static GetPageRoute generateRoute(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: screens[settings.name] ?? getDefaultScreen,
      bindings: bindings[settings.name]?.call(),
    );
  }

  static Widget getDefaultScreen() => const Scaffold(
        body: Center(child: Text('Undefined')),
      );
}
