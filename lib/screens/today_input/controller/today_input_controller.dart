import 'package:get/get.dart';
import 'package:wecheck/repository/today_input_repository.dart';


class TodayInputController extends GetxController {
  var todayInputRepository = TodayInputRepository();
  var conditionList = [].obs;
  var time = [].obs;
  var main = [].obs;
  var other = [].obs;
  @override
  void onInit() {
    todayInputRepository.doGetTodayInputData().then((value){
      conditionList.value = value.condition.list;
      time.value = value.time.list;
      main.value = value.main.list;
      other.value= value.other.list;
    });
    super.onInit();
  }
}
