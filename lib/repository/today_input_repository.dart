import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/today_input_data.dart';
import 'package:wecheck/theme/icons.dart';

class TodayInputRepository {
  Future<TodayInputData> doGetTodayInputData() {
    TodayInputData data = TodayInputData(
      Condition([
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
        ConditionItem(AppIcons.icEventDrinkWater, L.current.time),
      ]),
      Time(
        [
          InputRow(title: "Date & time", unit: "AAA 00, 0000   00:00"),
          InputRow(
              title: "Tag",
              unit: "Tag label",
              icon: AppIcons.icEventDrinkWater),
        ],
      ),
      MainData([
        InputRow(
            firstIcon: AppIcons.icEventDrinkWater,
            title: "title",
            value: "100",
            unit: "unit"),
        InputRow(
            firstIcon: AppIcons.icEventDrinkWater,
            title: "title",
            value: "100",
            unit: "unit"),
        InputRow(
            firstIcon: AppIcons.icEventDrinkWater,
            title: "title",
            value: "100",
            unit: "unit"),
        InputRow(
            firstIcon: AppIcons.icEventDrinkWater,
            title: "title",
            value: "100",
            unit: "unit"),
      ]),
      Other(
        [
          InputRow(
              firstIcon: AppIcons.icEventDrinkWater,
              title: "title",
              value: "100",
              unit: "unit"),
          InputRow(
              firstIcon: AppIcons.icEventDrinkWater,
              title: "title",
              value: "100",
              unit: "unit"),
          InputRow(
              firstIcon: AppIcons.icEventDrinkWater,
              title: "title",
              value: "100",
              unit: "unit"),
          InputRow(
              firstIcon: AppIcons.icEventDrinkWater,
              title: "title",
              value: "100",
              unit: "unit"),
          InputRow(
              firstIcon: AppIcons.icEventDrinkWater,
              title: "title",
              value: "111",
              unit: "unit"),
        ],
      ),
    );
    return Future.value(data);
  }
}
