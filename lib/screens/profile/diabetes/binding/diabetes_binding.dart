
import 'package:get/get.dart';
import 'package:wecheck/screens/profile/diabetes/controller/diabetes_controller.dart';

class DiabetesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiabetesController());
  }

}