import 'package:wecheck/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var initController = false;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Get.offAndToNamed(RouteName.settings);
    });
  }
}
