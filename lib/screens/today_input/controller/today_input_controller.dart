import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/model/condition_list_data.dart';
import 'package:wecheck/model/input_data.dart';
import 'package:wecheck/repository/today_input_repository.dart';
import 'package:wecheck/utils/constants.dart';

class TodayInputController extends GetxController {
  var todayInputRepository = TodayInputRepository();
  var initial = true;
  var conditions1 = <ConditionInput>[].obs;
  var dateAndTime = DateTime.now();
  var dateAndTimeFormated =
      DateFormat(Constant.fullDateTimeFormat).format(DateTime.now()).obs;
  var tagItem;
  InputData? bloodSugar;
  InputData? meals;
  InputData? insulin;
  InputData? medicine;

  InputData? a1c;
  InputData? steps;
  InputData? bloodPressure;
  InputData? tir;
  InputData? weight;

  @override
  void onInit() {
    todayInputRepository.doGetConditionList().then((value) {
      conditions1.value = value;
    });
    todayInputRepository.doGetTagItemData().then((value) {
      tagItem = value;
    });
    todayInputRepository.doGetInputData().then((value) {
      bloodSugar = value[0];
      meals = value[1];
      insulin = value[2];
      medicine = value[3];

      a1c = value[4];
    });
    super.onInit();
  }
}
