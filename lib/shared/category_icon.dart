import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final dynamic bgColor;
  final IconData iconData;
  const CategoryIcon(
      {super.key, required this.bgColor, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      padding: const EdgeInsets.all(4),
      child: Icon(
        iconData,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
