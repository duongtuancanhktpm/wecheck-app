import 'package:wecheck/model/condition_list_data.dart';
import 'package:wecheck/model/input_data.dart';
import 'package:wecheck/model/tag_item_data.dart';
import 'package:wecheck/theme/icons.dart';

class TodayInputRepository {
  Future<List<ConditionInput>> doGetConditionList() async {
    List<ConditionInput> conditions = [
      ConditionInput(AppIcons.icEventStressFill, "Hight Blood Sugar"),
      ConditionInput(AppIcons.icEventStressStroke, "Low Blood Sugar"),
      ConditionInput(AppIcons.icEventMask, "Sick Day"),
      ConditionInput(AppIcons.icEventRunning, "Sports"),
      ConditionInput(AppIcons.icEventDrinkWater, "Woke Up"),
      ConditionInput(AppIcons.icEventStressFill, "Bath"),
      ConditionInput(AppIcons.icEventStressFill, "Sleep"),
      ConditionInput(AppIcons.icEventStressFill, "ARE"),
    ];

    return Future.value(conditions);
  }

  Future<TagItemData> doGetTagItemData() {
    return Future.value(TagItemData(AppIcons.icEventDrinkWater, "Tag name"));
  }

  Future<List<InputData>> doGetInputData() {
    List<InputData> datas = [
      InputData("155"),
      InputData("980"),
      InputData("3"),
      InputData("2"),
      InputData("7.9"),
      InputData("6500"),
      InputData("100"),
      InputData("51"),
      InputData("75.4"),
    ];

    return Future.value(datas);
  }
}
