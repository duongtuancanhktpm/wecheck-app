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
