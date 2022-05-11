import 'package:wecheck/services/network/network_info.dart';
import 'package:wecheck/services/shared_data/storage_service.dart';
import 'package:wecheck/utils/database_helper.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    injectNetworkDependencies();
    injectControllers();
    await DatabaseHelper().initDataBase();
    await StorageService().init();
  }

  void injectControllers() {}

  void injectNetworkDependencies() {
    Get.put(NetworkInfo());
  }
}
