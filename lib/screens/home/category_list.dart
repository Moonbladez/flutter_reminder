import 'package:flutter/material.dart';

import 'package:reminders/models/category_collection.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categoryCollection});

  final CategoryCollection categoryCollection;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.categoryCollection.categories.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: const Icon(Icons.check),
          ),
          tileColor: Colors.blueGrey,
          trailing: const Icon(Icons.menu),
          title: Row(
            children: [
              widget.categoryCollection.categories[index].icon,
              const SizedBox(width: 10),
              Text(widget.categoryCollection.categories[index].name),
            ],
          ),
        );
      },
    );
  }
}
