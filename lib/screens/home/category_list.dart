import 'package:flutter/material.dart';
import 'package:reminders/models/category.dart';

import 'package:reminders/models/category_collection.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categoryCollection});

  final CategoryCollection categoryCollection;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _evenColor = Colors.blueGrey.withOpacity(0.2);
  final _oddColor = Colors.blueGrey.withOpacity(0.1);
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: widget.categoryCollection.categories.length,
      itemBuilder: (BuildContext context, int index) {
        final Category category = widget.categoryCollection.categories[index];
        return ListTile(
          key: UniqueKey(),
          leading: Container(
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: const Icon(Icons.check),
          ),
          title: Row(
            children: [
              category.icon,
              const SizedBox(width: 10),
              Text(category.name),
            ],
          ),
          tileColor: index.isEven ? _evenColor : _oddColor,
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setState(
          () {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final Category item =
                widget.categoryCollection.categories.removeAt(oldIndex);
            widget.categoryCollection.categories.insert(newIndex, item);
          },
        );
      },
    );
  }
}
