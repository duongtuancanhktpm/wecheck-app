import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/today_input_data.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/utils/constants.dart';

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
          InputRow(
              title: L.current.dateAndTime,
              unit: DateFormat(Constant.fullDateTimeFormat)
                  .format(DateTime.now())),
          InputRow(
              title: L.current.tag,
              unit: "Tag label",
              icon: AppIcons.icHomeSelected),
        ],
      ),
      MainData([
        InputRow(
            firstIcon: AppIcons.icEventDrinkWater,
            title: L.current.bloodSugar,
            value: "155",
            unit: Constant.bloodSugarUnit),
        InputRow(
            firstIcon: AppIcons.icEventEat,
            title: L.current.meals,
            value: "980",
            unit: Constant.mealsUnit),
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
