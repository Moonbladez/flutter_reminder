import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:reminders/models/common/custom_icon.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(id: "bar_chart", icon: CupertinoIcons.bars),
    CustomIcon(id: "alarm", icon: CupertinoIcons.alarm),
    CustomIcon(id: "bell", icon: CupertinoIcons.bell),
    CustomIcon(id: "book", icon: CupertinoIcons.book),
    CustomIcon(id: "bookmark", icon: CupertinoIcons.bookmark),
    CustomIcon(id: "calendar", icon: CupertinoIcons.calendar),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);
  CustomIcon findById(String id) => _icons.firstWhere((icon) => icon.id == id);
}
