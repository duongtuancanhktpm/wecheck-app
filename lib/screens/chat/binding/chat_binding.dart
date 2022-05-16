import 'package:get/get.dart';
import 'package:wecheck/screens/chat/controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}