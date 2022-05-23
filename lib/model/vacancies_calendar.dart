import 'package:wecheck/model/vacancies.dart';

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
