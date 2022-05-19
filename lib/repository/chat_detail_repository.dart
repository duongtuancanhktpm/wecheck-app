import 'dart:convert';

import 'package:wecheck/model/message.dart';

class ChatDetailRepository {
  Future<List<UserMessage>> doGetListUserMessage() async {
    var response = """
    {
    "success": 1,
     "data": [
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "1",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "1",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "1",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "1",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": "2022-05-19 12:45:03",
           "type" : "2",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          },
          {
           "id": "1",
           "body": "this is message",
           "timestamp": null,
           "type" : "1",
           "user" : {
              "avatar_url": "https://www.w3schools.com/w3images/avatar2.png",
              "name": "people 1"
           }
          }
       ]
    }
    """;
    var json = await jsonDecode(response);
    var userMessageResponse = (json["data"] as List)
        .map(
          (e) => UserMessage.fromJson(e),
        )
        .toList();
    return Future.value(userMessageResponse);
  }
}
