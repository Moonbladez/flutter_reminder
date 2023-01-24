import 'package:flutter/material.dart';
import 'package:reminders/screens/home/category_grid.dart';
import 'package:reminders/screens/home/category_list.dart';
import 'package:reminders/screens/home/footer.dart';

import '../../models/category_collection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Layout { grid, list }

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();

  Layout layoutType = Layout.grid;

  @override
  Widget build(BuildContext context) {
    print(layoutType);
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: () {
            if (layoutType == Layout.grid) {
              setState(() {
                layoutType = Layout.list;
              });
            } else {
              setState(() {
                layoutType = Layout.grid;
              });
            }
          },
          child: Text(
            layoutType == Layout.grid ? 'Edit' : 'Done',
            style: const TextStyle(color: Colors.white),
          ),
        )
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: layoutType == Layout.grid
                ? CategoryGrid(
                    categoryCollection: categoryCollection,
                  )
                : CategoryList(categoryCollection: categoryCollection),
          ),
          const Footer()
        ],
      ),
    );
  }
}