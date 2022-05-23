class TodayInputData {
  Condition condition;
  Time time;
  MainData main;
  Other other;

  TodayInputData(this.condition, this.time, this.main, this.other);
}

class Condition {
  List<ConditionItem> list;
  Condition(this.list);
}

class ConditionItem {
  String icon;
  String label;

  ConditionItem(this.icon, this.label);
}

class Time {
  List<InputRow> list;

  Time(this.list);
}

class MainData {
  List<InputRow> list;

  MainData(this.list);
}

class Other {
  List<InputRow> list;

  Other(this.list);
}

class InputRow {
  String? firstIcon;
  String? title;
  String? picture;
  String? icon;
  String? value;
  String? unit;
  bool? expanded;

  InputRow(
      {String? firstIcon,
      String? title,
      String? picture,
      String? icon,
      String? value,
      String? unit,
      bool? expanded}) {
    this.expanded = false;
    if(firstIcon!=null) this.firstIcon = firstIcon;
    if(title!=null) this.title = title;
    if(picture!=null) this.picture = picture;
    if(icon!=null) this.icon = icon;
    if(value!=null) this.value = value;
    if(unit!=null) this.unit = unit;
    if (expanded != null) this.expanded = expanded;
  }
}
