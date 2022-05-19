import 'dart:convert';

import 'package:wecheck/model/group_chat.dart';

class GroupChatRepository {
  Future<List<Partner>> doGetListPartner() async {
    var partners = """
      {
        "success": 0,
        "data": [
          {
            "partner_url" : "https://smartyads.com/images/uploads/Boosting-ad-revenue-with-right-advertising-partnership.png",
            "name" : "Partner 1",
            "description" : "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
            "create_at" : "2022-05-18 12:34:44"
          },
          {
            "partner_url" : "https://smartyads.com/images/uploads/Boosting-ad-revenue-with-right-advertising-partnership.png",
            "name" : "Partner 1",
            "description" : "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
            "create_at" : "2022-05-18 12:34:44"
          },
          {
            "partner_url" : "https://smartyads.com/images/uploads/Boosting-ad-revenue-with-right-advertising-partnership.png",
            "name" : "Partner 1",
            "description" : "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
            "create_at" : "2022-05-18 12:34:44"
          }
        ]
      }
    """;
    var json = await jsonDecode(partners);
    var partnerResponse = (json["data"] as List)
        .map(
          (e) => Partner.fromJson(e),
        )
        .toList();
    return Future.value(partnerResponse);
  }

  Future<List<GroupUser>> doGetListGroupUser() async {
    var users = """
      {
        "success": 0,
        "data": [
          {
            "name_group": "Arkey Hospital group",
            "description": "Hello, the next chat will be on",
            "create_at": "2022-05-18 12:45:00",
            "users": [
               {
                 "avatar_url" : null,
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               }
            ]
          },
          {
            "name_group": "Arkey Hospital group",
            "description": "Hello, the next chat will be on",
            "create_at": "2022-05-18 12:45:00",
            "users": [
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               }
            ]
          },
          {
            "name_group": "Arkey Hospital group",
            "description": "Hello, the next chat will be on",
            "create_at": "2022-05-18 12:45:00",
            "users": [
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               },
               {
                 "avatar_url" : "https://www.w3schools.com/howto/img_avatar.png",
                 "name" : "People 1"
               }
            ]
          }
        ]
      }
    """;
    var json = await jsonDecode(users);
    var partnerResponse = (json["data"] as List)
        .map(
          (e) => GroupUser.fromJson(e),
        )
        .toList();
    return Future.value(partnerResponse);
  }

  Future<List<MedicalInstitute>> doGetListMedicalInstitute() async {
    var medicalInstitutes = """
      {
        "success": 0,
        "data": [
          {
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "name" : "Hospital Comples",
            "description" : "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
            "create_at" : "2022-05-15 12:45:00"
          },
          {
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "name" : "Hospital Comples",
            "description" : "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
            "create_at" : "2022-05-15 12:45:00"
          },
          {
            "image_url" : "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
            "name" : "Hospital Comples",
            "description" : "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
            "create_at" : "2022-05-15 12:45:00"
          }
        ]
      }
    """;
    // var medicalInstitutes = """
    //     {
    //       "success": 1,
    //       "error": {
    //          "error_code": "E001",
    //          "error_message": "an error message"
    //       }
    //     }
    // """;
    var json = await jsonDecode(medicalInstitutes);
    var partnerResponse = (json["data"] as List)
        .map(
          (e) => MedicalInstitute.fromJson(e),
        )
        .toList();
    return Future.value(partnerResponse);
  }
}
