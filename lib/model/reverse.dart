class HospitalReverse {
  final String? name;
  final String? imageUrl;
  final String? lastTimeReverse;
  final List<VacanciesCalendar>? vacancies;

  HospitalReverse(
    this.name,
    this.imageUrl,
    this.lastTimeReverse,
    this.vacancies,
  );

  factory HospitalReverse.fromJson(dynamic json) {
    return HospitalReverse(
      json["name"] as String?,
      json["image_url"] as String?,
      json["last_time_reverse"] as String?,
      (json["vacancies_calendar"] as List?)
          ?.map(
            (e) => VacanciesCalendar.fromJson(e),
          )
          .toList(),
    );
  }
}

class VacanciesCalendar {
  final String? dateReverse;
  final List<Vacancies>? vacancies;

  VacanciesCalendar(this.dateReverse, this.vacancies);

  factory VacanciesCalendar.fromJson(dynamic json) {
    return VacanciesCalendar(
      json["date_reverse"] as String?,
      (json["vacancies"] as List?)?.map((e) => Vacancies.fromJson(e)).toList(),
    );
  }
}

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
