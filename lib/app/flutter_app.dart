
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wecheck/app/app_bindings.dart';
import 'package:wecheck/configurations/environments.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/services/app_lifecycle_observer.dart';
import 'package:wecheck/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:wecheck/utils/orientation_helpers.dart';

class FlutterApp extends StatefulWidget {
  final EnvironmentType? environment;

  const FlutterApp({Key? key, this.environment}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FlutterAppState();
}

class FlutterAppState extends State<FlutterApp> {
  final _observer = NavigatorObserverWithOrientation();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // return ScreenUtilInit(
    //   designSize: const Size(414, 896),
    //   builder: (child) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      theme: AppTheme.base(Get.theme).appTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RouteName.splash,
      initialBinding: AppBinding(),
      enableLog: true,
      localizationsDelegates: [
        L.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L.delegate.supportedLocales,
      navigatorObservers: [_observer],
    );
    //   }
    // );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(AppLifecycleObserver());
    print('start app lifecycle observer');

    AppLifecycleObserver().status.listen((AppLifecycleState state) {
      print(Get.currentRoute);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(AppLifecycleObserver());
    print('finish app lifecycle observer');
    super.dispose();
  }
}
