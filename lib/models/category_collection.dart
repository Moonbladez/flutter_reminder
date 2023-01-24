import 'package:flutter/material.dart';
import 'package:reminders/models/category.dart';
import 'package:reminders/shared/category_icon.dart';

class CategoryCollection {
  final List<Category> categories = [
    Category(
      int: "today",
      name: "Today",
      icon: const CategoryIcon(
          bgColor: Colors.lightBlueAccent,
          iconData: Icons.edit_calendar_rounded),
    ),
    Category(
      int: "scheduled",
      name: "Sheduled",
      icon: const CategoryIcon(
          bgColor: Colors.red, iconData: Icons.calendar_month_rounded),
    ),
    Category(
      int: "all",
      name: "All",
      icon: const CategoryIcon(
          bgColor: Colors.blueGrey, iconData: Icons.inbox_rounded),
    ),
    Category(
      int: "flagged",
      name: "Flagged",
      icon: const CategoryIcon(
          bgColor: Colors.orange, iconData: Icons.flag_rounded),
    )
  ];
}