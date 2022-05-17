import 'package:wecheck/screens/bslog/bslog_screen.dart';
import 'package:wecheck/screens/account/sign_up/binding/sign_up_main_binding.dart';
import 'package:wecheck/screens/account/sign_up/sign_up_main_screen.dart';
import 'package:wecheck/screens/chat/binding/chat_binding.dart';
import 'package:wecheck/screens/chat/chat_screen.dart';
import 'package:wecheck/screens/chat_detail/chat_detail_screen.dart';
import 'package:wecheck/screens/home/binding/home_binding.dart';
import 'package:wecheck/screens/home/home_screen.dart';
import 'package:wecheck/screens/root/binding/root_binding.dart';
import 'package:wecheck/screens/root/root_screen.dart';
import 'package:wecheck/screens/setting/binding/setting_binding.dart';
import 'package:wecheck/screens/account/reset_password/binding/reset_password_binding.dart';
import 'package:wecheck/screens/account/reset_password/reset_password_screen.dart';
import 'package:wecheck/screens/account/sign_in/binding/sign_in_binding.dart';
import 'package:wecheck/screens/account/sign_in/sign_in_screen.dart';
import 'package:wecheck/screens/setting/setting_screen.dart';
import 'package:wecheck/screens/splash/bindings/splash_binding.dart';
import 'package:wecheck/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/screens/timeline/binding/timeline_binding.dart';
import 'package:wecheck/screens/timeline/timeline_screen.dart';

class RouteName {
  static const String splash = "splash";
  static const String root = "root";
  static const String home = "home";
  static const String timeline = "timeline";
  static const String chat = "chat";
  static const String chatDetail = "chat/details";
  static const String settings = "setting";
  static const String bsLog = "home/bsLog";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String signUpMain = "/signUpMain";
  static const String resetPassword = "/resetPassword";
  static const String bsLog = "home/bsLog";
}

class AppRoutes {
  static final screens = <String, Widget Function()>{
    RouteName.splash: () => const SplashScreen(),
    RouteName.root: () => const RootScreen(),
    RouteName.home: () => const HomeScreen(),
    RouteName.timeline: () => const TimeLineScreen(),
    RouteName.chat: () => const ChatScreen(),
    RouteName.settings: () => const SettingScreen(),
    RouteName.bsLog: () => BloodSugarLogScreen(),
    RouteName.signIn: () => const SignInScreen(),
    RouteName.signUpMain: () => const SignUpMainScreen(),
    RouteName.resetPassword: () => const ResetPasswordScreen(),
    RouteName.chatDetail: () => const ChatDetailScreen(),
  };

  static final bindings = <String, List<Bindings> Function()>{
    RouteName.splash: () => [SplashBinding()],
    RouteName.root: () => [RootBinding()],
    RouteName.home: () => [HomeBinding()],
    RouteName.timeline: () => [TimeLineBinding()],
    RouteName.chat: () => [ChatBinding()],
    RouteName.settings: () => [SettingBinding()],
    RouteName.signIn: () => [SignInBinding()],
    RouteName.signUpMain: () => [SignUpBinding()],
    RouteName.resetPassword: () => [ResetPasswordBinding()],
  };

  static GetPageRoute generateRoute(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: screens[settings.name] ?? getDefaultScreen,
      bindings: bindings[settings.name]?.call(),
    );
  }

  static Widget getDefaultScreen() => const Scaffold(
    backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Undefined',
          ),
        ),
      );
}
