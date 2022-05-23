import 'package:get/get.dart';
import 'package:wecheck/model/health_data.dart';
import 'package:wecheck/repository/bslog_repository.dart';

class BloodSugarLogController extends GetxController {
  var healthData = <HealthData>[].obs;
  BloodSugarLogRepository repository = BloodSugarLogRepository();

  @override
  void onInit() {
    repository.doGetListHealthData().then((value) {
      healthData.value = value;
    });
    super.onInit();
  }
}