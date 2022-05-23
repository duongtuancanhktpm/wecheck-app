import 'package:get/get.dart';
import 'package:wecheck/repository/create_diabetes_repository.dart';
import 'package:wecheck/routes/routes.dart';

class DiabetesController extends GetxController {
  Rx<bool> isHaveDiabetes = false.obs;
  Rx<String> valueHaveDiabetes = 'Type 1'.obs;

  Rx<bool> isTakingMedicine = false.obs;
  Rx<String> valueTakingMedicine = 'Type Of Medicine'.obs;

  Rx<bool> isTakingInsulin = false.obs;
  Rx<String> valueTakingInsulin = 'Type Of Insulin'.obs;

  var createDiabetesRepository = CreateDiabetesRepository();

  final List<String> listTypeDiabetes = [
    'Type 1',
    'Type 2',
    'Type 3',
    'Type 4',
  ];

  final List<String> listTakingMedicine = [
    'Type Of Medicine',
    'Medicine 1',
    'Medicine 2'
  ];
  final List<String> listTakingInsulin = [
    'Type Of Insulin',
    'Insulin 1',
    'Insulin 2'
  ];

  void goToHomeScreen() {
    Get.offAndToNamed(RouteName.root);
  }

}
