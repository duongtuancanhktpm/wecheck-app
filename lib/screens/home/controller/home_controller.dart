
import 'package:get/get.dart';
import 'package:wecheck/model/home/blood_sugar_model.dart';
import 'package:wecheck/model/home/insulin_model.dart';
import 'package:wecheck/model/home/meals_model.dart';
import 'package:wecheck/model/home/small_menu.dart';
import 'package:wecheck/model/home/step_model.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/theme/theme.dart';

class HomeController extends GetxController {
  late List<dynamic> listMenuIndex;
  late List<dynamic> listMenuBottom;

  @override
  void onInit() {
    listMenuIndex = [];
    listMenuIndex.add(BloodSugarEntity(1));
    listMenuIndex.add(MealsEntity(2));
    listMenuIndex.add(InsulinEntity(3));
    listMenuIndex.add(StepEntity(4));

    listMenuBottom = [];
    listMenuBottom.add(SmallMenu(AppIcons.icEventStressFill, "SHIMEI"));
    listMenuBottom.add(SmallMenu(AppIcons.icEventTakeMedicines, "Graph"));
    listMenuBottom.add(SmallMenu(AppIcons.icEventDrinkWater, "HbA1c"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "BS Log"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "BS Log"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "BS Log"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "BS Log"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "BS Log"));
    listMenuBottom.add(SmallMenu(AppIcons.icChatUnSelected, "Add"));

    super.onInit();
  }

  void goToInsulinChartHorizontalScreen() {
     Get.toNamed(RouteName.insulinGraph);

    // AutoOrientation.landscapeRightMode();
  }
}
