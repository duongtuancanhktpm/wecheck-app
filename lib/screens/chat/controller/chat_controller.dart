import 'package:get/get.dart';

class ChatController extends GetxController {
  var selectedSegment = 0.obs;
  void changeSelectedSegment(int? tab) {
    if (tab != null) {
      selectedSegment.value = tab;
    }
  }
}
