import 'package:flutter/services.dart';
import 'package:wecheck/app/flutter_app.dart';
import 'package:flutter/material.dart';
import 'package:wecheck/theme/colors.dart';

import 'configurations/environments.dart';

/// mainApp
void mainApp(EnvironmentType environment) async {
  Environment.config(environment);
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.white,
      statusBarColor: AppColors.aliceBlue,
      statusBarIconBrightness: Brightness.dark));
  runApp(MaterialApp(
    home: FlutterApp(
      environment: environment,
    ),
  ));
}
