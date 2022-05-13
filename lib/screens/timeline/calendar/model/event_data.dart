
class EventData implements BaseEvent {
  @override
  String dateTime;
  String dayType;
  int status;
  List<EventDetailData> listEvent;

  EventData(this.dateTime, this.dayType, this.status, this.listEvent);


}

class EventDetailData {
  String dateTime;
  String eventType;
  int status;
  String value;

  EventDetailData(this.dateTime, this.eventType, this.status, this.value);
}

class BaseEvent {
  String dateTime;

  BaseEvent(this.dateTime);
}
