import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/model/settings_profile_data.dart';
import 'package:wecheck/theme/images.dart';

class SettingsProfileRepisitory {
  Future<SettingsProfileData> doGetSettingsProfileData() {
    return Future.value(
      SettingsProfileData(
          Profile(AppImages.defaultImage, "Geted name", "geted email")),
    );
  }
}
