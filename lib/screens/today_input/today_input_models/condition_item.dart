import 'package:flutter/material.dart';

enum Condition{
  HightBloodSugar,
  LowBloodSugar,
  SickDay,
  Sports,
  WokeUp,
  Bath,
  Sleep,
  ARE
}

class ConditionItem{
  late String label;
  late IconData icon;
  late String? iconPath = "";
  Map<Condition, String> conditionLabel = {
    Condition.HightBloodSugar: "Hight Blood Sugar",
    Condition.LowBloodSugar: "Low Blood Sugar",
    Condition.SickDay: "SickDay",
    Condition.Sports: "Sports",
    Condition.WokeUp: "WokeUp",
    Condition.Bath: "Bath",
    Condition.Sleep: "Sleep",
    Condition.ARE: "ARE",
  };
  Map<Condition, String> conditionIconPath = {
    Condition.HightBloodSugar: "assets/icons/ic_event_stress_fill.svg",
    Condition.LowBloodSugar: "assets/icons/ic_event_stress_stroke.svg",
    Condition.SickDay: "assets/icons/ic_event_mask.svg",
    Condition.Sports: "assets/icons/ic_event_running.svg",
    Condition.WokeUp: "assets/icons/ic_event_running.svg",
    Condition.Bath: "assets/icons/ic_event_running.svg",
    Condition.Sleep: "assets/icons/ic_event_running.svg",
    Condition.ARE: "assets/icons/ic_event_running.svg",
  };


  List<ConditionItem> getConditions(){
    List<ConditionItem> list = [];
    conditionLabel.forEach((key, value) {
      ConditionItem newItem = ConditionItem();
      newItem.icon = Icons.person;
      newItem.label = value;
      newItem.iconPath = conditionIconPath[key];

      list.add(newItem);
    });

    return list;
  }
}