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

class User {
  final String? avatarUrl;
  final String? name;

  User({this.avatarUrl, this.name});

  factory User.fromJson(dynamic json) {
    return User(
      avatarUrl: json["avatar_url"] as String?,
      name: json["name"] as String?
    );
  }
}

class MedicalInstitute {
  final String? imageUrl;
  final String? name;
  final String? description;
  final String? createAt;

  MedicalInstitute({this.imageUrl, this.name, this.description, this.createAt});
  
  factory MedicalInstitute.fromJson(dynamic json) {
    return MedicalInstitute(
      imageUrl: json["image_url"] as String?,
      name: json["name"] as String?,
      description: json["description"] as String?,
      createAt: json["create_at"] as String
    );
  }
}

class Partner {
  final String? partnerUrl;
  final String? name;
  final String? description;
  final String? createAt;

  Partner({this.partnerUrl, this.name, this.description, this.createAt});
  
  factory Partner.fromJson(dynamic json) {
    return Partner(
      partnerUrl: json["partner_url"] as String?,
      name: json["name"] as String?,
      description: json["description"] as String?,
      createAt: json["create_at"] as String?
    );
  }
}
