import 'package:reminders/shared/category_icon.dart';

class Category {
  final String int;
  final String name;
  bool isChecked;
  final CategoryIcon icon;

  Category(
      {required this.int,
      required this.name,
      this.isChecked = true,
      required this.icon});
}
