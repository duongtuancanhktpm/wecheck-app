class GroupUser {
  final List<User> users;
  final String nameGroup;
  final String description;
  final String createAt;

  GroupUser(this.users, this.nameGroup, this.description, this.createAt);
}

class User {
  final String avatarUrl;
  final String name;

  User(this.avatarUrl, this.name);
}

class MedicalInstitute {
  final String imageUrl;
  final String name;
  final String description;
  final String createAt;

  MedicalInstitute(this.imageUrl, this.name, this.description, this.createAt);
}

class Partner {
  final String partnerUrl;
  final String name;
  final String description;
  final String createAt;

  Partner(this.partnerUrl, this.name, this.description, this.createAt);
}
