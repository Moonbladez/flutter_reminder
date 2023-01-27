import 'dart:ui';

class CustomColor {
  String id;
  Color color;
  bool isSelected;

  CustomColor({
    required this.id,
    required this.color,
    this.isSelected = false,
  });
}
