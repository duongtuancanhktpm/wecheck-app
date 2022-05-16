import 'package:wecheck/screens/chat/binding/chat_binding.dart';
import 'package:wecheck/screens/chat/chat_screen.dart';
import 'package:wecheck/screens/home/binding/home_binding.dart';
import 'package:wecheck/screens/home/home_screen.dart';
import 'package:wecheck/screens/root/binding/root_binding.dart';
import 'package:wecheck/screens/root/root_screen.dart';
import 'package:wecheck/screens/setting/binding/setting_binding.dart';
import 'package:wecheck/screens/splash/bindings/splash_binding.dart';
import 'package:wecheck/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/screens/timeline/binding/timeline_binding.dart';
import 'package:wecheck/screens/timeline/timeline_screen.dart';

import '../screens/setting/setting_screen.dart';

class RouteName {
  static const String splash = "splash";
  static const String root = "root";
  static const String home = "home";
  static const String timeline = "timeline";
  static const String chat = "chat";
  static const String settings = "setting";
}

class AppRoutes {
  static final screens = <String, Widget Function()>{
    RouteName.splash: () => SplashScreen(),
    RouteName.root: () => const RootScreen(),
    RouteName.home: () => const HomeScreen(),
    RouteName.timeline: () => const TimeLineScreen(),
    RouteName.chat: () => const ChatScreen(),
    RouteName.settings: () => const SettingScreen(),
  };

  static final bindings = <String, List<Bindings> Function()>{
    RouteName.splash: () => [SplashBinding()],
    RouteName.root: () => [RootBinding()],
    RouteName.home: () => [HomeBinding()],
    RouteName.timeline: () => [TimeLineBinding()],
    RouteName.chat: () => [ChatBinding()],
    RouteName.settings: () => [SettingBinding()]
  };

  static GetPageRoute generateRoute(RouteSettings settings) {
    print("routeName: ${settings.name}");
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
