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
