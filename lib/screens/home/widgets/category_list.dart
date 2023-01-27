import 'package:flutter/material.dart';
import 'package:reminders/models/category.dart';

import 'package:reminders/models/category_collection.dart';

const LIST_ITEM_HEIGHT = 60.0;

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categoryCollection});

  final CategoryCollection categoryCollection;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final Color _evenColor = Colors.blueGrey.withOpacity(0.2);
  final Color _oddColor = Colors.blueGrey.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: LIST_ITEM_HEIGHT * widget.categoryCollection.categories.length,
      child: ReorderableListView.builder(
        itemCount: widget.categoryCollection.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final Category category = widget.categoryCollection.categories[index];
          return SizedBox(
            key: UniqueKey(),
            height: LIST_ITEM_HEIGHT,
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: category.isChecked
                            ? Colors.blueAccent
                            : Colors.grey),
                    color: category.isChecked
                        ? Colors.blueAccent
                        : Colors.transparent,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: category.isChecked ? Colors.white : Colors.transparent,
                ),
              ),
              onTap: () {
                setState(
                  () {
                    category.toggleCheckbox();
                  },
                );
              },
              title: Row(
                children: [
                  category.icon,
                  const SizedBox(width: 10),
                  Text(category.name),
                ],
              ),
              tileColor: index.isEven ? _evenColor : _oddColor,
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(
            () {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final Category item =
                  widget.categoryCollection.removeItem(oldIndex);
              widget.categoryCollection.insert(newIndex, item);
            },
          );
        },
      ),
    );
  }
}
