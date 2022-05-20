import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/screens/chart_horizontal/controller/insulin_graph_horizontal_controller.dart';
import 'package:wecheck/theme/colors.dart';

class InsulinGraphHorizontalScreen
    extends GetView<InsulinGraphHorizontalController> {
  const InsulinGraphHorizontalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text("Landscape3")),
      body: Center(child: Text("This is the landscape-only screen3")),
    );
  }
}
