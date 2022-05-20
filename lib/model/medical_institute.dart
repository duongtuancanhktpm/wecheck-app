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
