import 'package:get/get.dart';
import 'package:wecheck/model/message.dart';
import 'package:wecheck/repository/chat_detail_repository.dart';

class ChatDetailController extends GetxController {
  var messages = <UserMessage>[].obs;
  var repository = ChatDetailRepository();

  @override
  void onInit() {
    repository.doGetListUserMessage().then((value) => messages.value = value);
    super.onInit();
  }
}