import 'package:wecheck/utils/extensions.dart';

enum EnvironmentType { development, production, staging }

abstract class EnvironmentBase {
  String get host;

  String get name;

  int get apiTimeout => 20000;
}

class _Development extends EnvironmentBase {
  @override
  String get host => 'https://www.google.com';

  @override
  String get name => EnvironmentType.development.text;
}

class _Staging extends EnvironmentBase {
  @override
  String get host => 'https://www.google.com';

  @override
  String get name => EnvironmentType.staging.text;
}

class _Production extends EnvironmentBase {
  @override
  String get host => 'https://www.google.com';

  @override
  String get name => EnvironmentType.production.text;
}

class Environment {
  static EnvironmentBase _environment = _Development();

  static String get host => _environment.host;

  static String get name => _environment.name;

  static int get apiTimeout => _environment.apiTimeout;

  static void config(EnvironmentType type) {
    switch (type) {
      case EnvironmentType.development:
        _environment = _Development();
        break;
      case EnvironmentType.production:
        _environment = _Production();
        break;
      case EnvironmentType.staging:
        _environment = _Staging();
        break;
    }
  }
}
