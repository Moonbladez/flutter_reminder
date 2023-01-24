import 'package:flutter/material.dart';
import 'package:reminders/models/category_collection.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    Key? key,
    required this.categoryCollection,
  }) : super(key: key);

  final CategoryCollection categoryCollection;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 8,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: categoryCollection.categories
          .map(
            (category) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF1A1910),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [category.icon, const Text("0")],
                    ),
                    Text(category.name),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
