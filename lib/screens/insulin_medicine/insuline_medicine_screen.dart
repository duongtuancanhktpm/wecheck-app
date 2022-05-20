import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wecheck/screens/insulin_medicine/controller/insulin_medicine_controller.dart';
import 'package:wecheck/theme/colors.dart';

class InsulinMedicineScreen extends GetView<InsulinMedicineController>{
  const InsulinMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.grey,);
  }

}