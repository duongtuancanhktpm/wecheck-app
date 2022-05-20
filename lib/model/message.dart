import 'package:wecheck/model/user.dart';

class UserMessage {
  final String? id;
  final String? body;
  final String? timestamp;
  final String? type;
  final User? user;

  UserMessage({this.id, this.body, this.timestamp, this.type, this.user});

  factory UserMessage.fromJson(dynamic json) {
    return UserMessage(
     id: json["id"] as String?,
     body: json["body"] as String?,
     timestamp: json["timestamp"] as String?,
      type: json["type"] as String?,
      user: User.fromJson(json["user"])
    );
  }
}