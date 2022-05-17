import 'package:get/get.dart';
import 'package:wecheck/model/home/blood_sugar_model.dart';
import 'package:wecheck/model/home/insulin_model.dart';
import 'package:wecheck/model/home/meals_model.dart';
import 'package:wecheck/model/home/step_model.dart';

class HomeController extends GetxController {
  late List<dynamic> listMenuIndex;

  @override
  void onInit() {
    listMenuIndex = [];
    listMenuIndex.add(BloodSugarEntity(1));
    listMenuIndex.add(MealsEntity(2));
    listMenuIndex.add(InsulinEntity(3));
    listMenuIndex.add(StepEntity(4));

    super.onInit();
  }
}
