import 'package:get/get.dart';
import 'package:wecheck/model/reverse.dart';
import 'package:wecheck/repository/reverse_repository.dart';

class ReverseController extends GetxController {
  var hospitalReverse = <HospitalReverse>[].obs;
  var repository = ReverseRepository();
  var rotateIcon = false.obs;

  void setRotated(bool isRotate) {
    rotateIcon.value = isRotate;
  }

  @override
  void onInit() {
    repository.doGetListHospitalReverse().then((value) {
      if (value.isNotEmpty) {
        hospitalReverse.value = value;
      }
    });
    super.onInit();
  }
}