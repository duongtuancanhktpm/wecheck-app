import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/screens/today_input/today_input_models/condition_item.dart';

class TodayInputController extends GetxController{
  var conditions = ConditionItem().getConditions().obs;

  //var DnT = DateTime.now();
  var DnTValue = DateFormat("MMMM dd, yyyy    kk:mm").format(DateTime.now()).obs;


}