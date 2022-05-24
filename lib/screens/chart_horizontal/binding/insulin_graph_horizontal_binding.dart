
import 'package:get/get.dart';
import 'package:wecheck/screens/chart_horizontal/controller/insulin_graph_horizontal_controller.dart';

class InsulinGraphHorizontalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InsulinGraphHorizontalController());
  }
}