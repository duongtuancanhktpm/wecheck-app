import 'package:wecheck/model/user.dart';

class GroupUser {
  final List<User>? users;
  final String? nameGroup;
  final String? description;
  final String? createAt;

  GroupUser({this.users, this.nameGroup, this.description, this.createAt});
  
  factory GroupUser.fromJson(dynamic json) {
    return GroupUser(
      users: (json["users"] as List?)?.map((e) => User.fromJson(e)).toList(),
      nameGroup: json["name_group"] as String?,
      description: json["description"] as String?,
      createAt: json["create_at"] as String
    );
  }
}
