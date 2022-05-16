import 'package:wecheck/services/api/api_service.dart';
import 'package:wecheck/theme/icons.dart';

import '../model/event_data.dart';

class TimelineRepository {
  ApiService apiService = ApiService();

  Future<List<EventData>> doGetListEventData() {
    final List<EventData> _events = [
      EventData("2022-04-28 00:00:00", AppIcons.icEventRunning, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventRunning, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventMask, 1, "140"),
      ]),
      EventData("2022-05-02 00:00:00", AppIcons.icEventMask, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "110"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "120"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "130"),
      ]),
      EventData("2022-05-05 00:00:00", AppIcons.icEventStressStroke, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-07 00:00:00", AppIcons.icEventStressFill, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-09 00:00:00", AppIcons.icEventRunning, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-10 00:00:00", AppIcons.icEventStressStroke, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-15 00:00:00", AppIcons.icEventStressStroke, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-19 00:00:00", AppIcons.icEventStressStroke, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
      EventData("2022-05-22 00:00:00", AppIcons.icEventStressStroke, 1, [
        EventDetailData("2022-01-01 08:12:00", AppIcons.icEventDrinkWater, 1, "140"),
        EventDetailData("2022-01-01 08:14:00", AppIcons.icEventDrinkWater, 1, "140"),
      ]),
    ];
    return Future.value(_events);
  }
}