import 'package:wecheck/app/flutter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'configurations/environments.dart';

/// mainApp
void mainApp(EnvironmentType environment) async {
  Environment.config(environment);
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(FlutterApp(environment: environment,));
}
