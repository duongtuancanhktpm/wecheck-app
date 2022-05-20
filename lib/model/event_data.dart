
import 'package:wecheck/model/event_detail_data.dart';

class EventData {
  String dateTime;
  String dayType;
  int status;
  List<EventDetailData> listEvent;

  EventData(this.dateTime, this.dayType, this.status, this.listEvent);


}

