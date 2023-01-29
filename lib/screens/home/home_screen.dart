import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/screens/home/widgets/category_grid.dart';
import 'package:reminders/screens/home/widgets/category_list.dart';
import 'package:reminders/screens/home/widgets/footer.dart';
import 'package:reminders/screens/home/widgets/todolists.dart';

import '../../models/category_collection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Layout { grid, list }

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();

  Layout layoutType = Layout.grid;

  List<ToDoList> todoLists = [];

  addNewList(ToDoList list) {
    Provider.of<ToDoListCollection>(context, listen: false).addToDoList(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: layoutType == Layout.grid
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: CategoryGrid(
                    categories: categoryCollection.selectedCategories,
                  ),
                  secondChild:
                      CategoryList(categoryCollection: categoryCollection),
                ),
                const TodoLists(),
              ],
            ),
          ),
          const Footer()
        ],
      ),
    );
  }
}
