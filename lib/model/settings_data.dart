import 'package:wecheck/services/database/table/user_table.dart';

class SettingsData{
  UserTable userProfile;
  SettingsData(this.userProfile);
}

class Profile{
  String avatar;
  String name;
  String email;
  Profile(this.avatar, this. name, this.email);
}

class UserProfile{
  String avatar;
  String name;
  String email;

  UserProfile(this.avatar, this.name, this.email);
}