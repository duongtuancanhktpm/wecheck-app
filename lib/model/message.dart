import 'package:wecheck/model/group_chat.dart';

class UserMessage {
  final String id;
  final String body;
  final String timestamp;
  final int type;
  final User user;

  UserMessage(this.id, this.body, this.timestamp, this.type, this.user);
}