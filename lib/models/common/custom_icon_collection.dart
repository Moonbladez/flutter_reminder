import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminders/models/common/custom_icon.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(
      id: "bar_chart",
      icon: const Icon(
        Icons.bar_chart,
        size: 30,
      ),
    ),
    CustomIcon(
      id: "alarm",
      icon: const Icon(
        Icons.alarm,
        size: 30,
      ),
    ),
    CustomIcon(
      id: "calendar_month",
      icon: const Icon(
        Icons.calendar_month,
        size: 30,
      ),
    ),
    CustomIcon(
      id: "waves",
      icon: const Icon(
        Icons.waves,
        size: 30,
      ),
    ),
    CustomIcon(
      id: "person",
      icon: const Icon(
        Icons.person,
        size: 30,
      ),
    ),
    CustomIcon(
      id: "folder",
      icon: const Icon(
        Icons.folder,
        size: 30,
      ),
    )
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);
  CustomIcon findById(String id) => _icons.firstWhere((icon) => icon.id == id);
}
