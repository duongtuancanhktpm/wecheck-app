class Vacancies {
  final String? startTime;
  final String? endTime;

  Vacancies(this.startTime, this.endTime);

  factory Vacancies.fromJson(dynamic json) {
    return Vacancies(
      json["start_time"] as String?,
      json["end_time"] as String?,
    );
  }
}
