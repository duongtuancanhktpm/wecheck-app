import 'package:get/get.dart';

import 'package:wecheck/screens/timeline/controller/timeline_controller.dart';

class TimeLineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimeLineController());
  }
}