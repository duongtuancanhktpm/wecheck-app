import 'package:wecheck/screens/root/binding/root_binding.dart';
import 'package:wecheck/screens/root/root_screen.dart';
import 'package:wecheck/screens/sign_in/binding/sign_in_binding.dart';
import 'package:wecheck/screens/sign_in/sign_in_screen.dart';
import 'package:wecheck/screens/splash/bindings/splash_binding.dart';
import 'package:wecheck/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteName {
  static const String splash = "/splash";
  static const String root = "/root";
  static const String home = "/home";
  static const String signIn = "/signIn";
}

class AppRoutes {
  static final screens = <String, Widget Function()>{
    RouteName.splash: () => SplashScreen(),
    RouteName.root: () => const RootScreen(),
    RouteName.signIn: () => const SignInScreen(),
  };

  static final bindings = <String, List<Bindings> Function()>{
    RouteName.splash: () => [SplashBinding()],
    RouteName.root: () => [RootBinding()],
    RouteName.signIn: () => [SignInBinding()],
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
