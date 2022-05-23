import 'package:wecheck/model/settings_data.dart';
import 'package:wecheck/theme/images.dart';

class SettingsRepository {
  Future<UserProfile> doGetUserProfile() {
    return Future.value(
        UserProfile(AppImages.defaultImage, "My name", "email@email.com"));
  }
}