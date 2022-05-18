import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/screens/today_input/today_input_models/condition_item.dart';
import 'package:wecheck/theme/colors.dart';



class TodayInputController extends GetxController {
  var conditions = ConditionItem().getConditions().obs;
  var DnTValue =
      DateFormat("MMMM dd, yyyy    kk:mm").format(DateTime.now()).obs;

  void onConditionTap(int index){
    conditions.value.forEach((newItem) {
      newItem.itemColor = AppColors.lightSlateGrey;
      newItem.borderColor = AppColors.pattensBlue;
      newItem.textColor = AppColors.lightSlateGrey;
    });
    conditions.value[index].itemColor = AppColors.ceruleanBlue;
    conditions.value[index].borderColor = AppColors.ceruleanBlue;
    conditions.value[index].backgroundColor = AppColors.solitude;
    conditions.refresh();

  }
}
