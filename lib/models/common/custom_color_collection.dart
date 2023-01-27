import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminders/models/common/custom_color.dart';

class CustomColorCollection {
  final List<CustomColor> _colors = [
    CustomColor(id: "blue_accent", color: Colors.blueAccent),
    CustomColor(id: "orange", color: Colors.orange),
    CustomColor(id: "red_accent", color: Colors.redAccent),
    CustomColor(id: "light_green", color: Colors.lightGreen),
    CustomColor(id: "deep_orange", color: Colors.deepOrange),
    CustomColor(id: "yellow_accent", color: Colors.yellowAccent),
  ];

  UnmodifiableListView<CustomColor> get colors => UnmodifiableListView(_colors);
  CustomColor findById(String id) =>
      _colors.firstWhere((color) => color.id == id);
}
