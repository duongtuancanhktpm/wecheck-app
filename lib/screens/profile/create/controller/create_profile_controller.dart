import 'package:get/get.dart';
import 'package:wecheck/repository/create_profile_repository.dart';
import 'package:wecheck/routes/routes.dart';

class CreateProfileController extends GetxController {
  Rx<String> valueCountry = 'Country'.obs;
  Rx<String> valueGender = 'Gender'.obs;

  var createProfileRepository = CreateProfileRepository();

  final List<String> listCountry = [
    'Country',
    'Japan',
    'Viet Nam',
    'Koria',
    'China',
    'Lao'
  ];

  final List<String> listGender = ['Gender', 'Male', 'Female'];

  void goToHomePage() {
    Get.toNamed(RouteName.home);
  }
}
