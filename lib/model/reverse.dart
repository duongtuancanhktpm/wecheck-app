import 'package:wecheck/model/vacancies_calendar.dart';

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
