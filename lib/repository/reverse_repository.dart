import 'dart:convert';

import 'package:wecheck/model/reverse.dart';

class ReverseRepository {
  Future<List<HospitalReverse>> doGetListHospitalReverse() async {
    var response = """
      {
        "success": 0,
        "data": [
          {
            "name": "Arkay Hospital",
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "last_time_reverse": "2022-04-19 12:45:32",
            "vacancies_calendar" : [
               {
                  "date_reverse" : "2022-04-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-04-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               }
            ]
          },
          {
            "name": "Arkay Hospital",
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "last_time_reverse": "2022-05-19 12:45:32",
            "vacancies_calendar" : [
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               }
            ]
          },
          {
            "name": "Arkay Hospital",
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "last_time_reverse": "2022-05-19 12:45:32",
            "vacancies_calendar" : [
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               },
               {
                  "date_reverse" : "2022-05-19 12:45:22",
                  "vacancies" : [
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       },
                       {
                          "start_time": "2022-05-19 10:00:00",
                          "end_time": "2022-05-19 11:00:00"
                       }
                  ]
               }
            ]
          }
        ]
      }
    """;
    var json = await jsonDecode(response);
    var reverseResponse = (json["data"] as List)
        .map(
          (e) => HospitalReverse.fromJson(e),
        )
        .toList();
    return Future.value(reverseResponse);
  }
}
