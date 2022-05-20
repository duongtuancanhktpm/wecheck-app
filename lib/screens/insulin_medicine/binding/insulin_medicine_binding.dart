import 'package:get/get.dart';
import 'package:wecheck/screens/insulin_medicine/controller/insulin_medicine_controller.dart';

class InsulinMedicineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InsulinMedicineController());
  }

}