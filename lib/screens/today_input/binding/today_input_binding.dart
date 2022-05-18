import 'package:get/get.dart';
import 'package:wecheck/screens/today_input/controller/today_input_controller.dart';

class TodayInputBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> TodayInputController());
  }

}