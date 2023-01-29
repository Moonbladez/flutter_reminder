import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/common/custom_color_collection.dart';
import 'package:reminders/models/common/custom_icon_collection.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/shared/category_icon.dart';

class TodoLists extends StatelessWidget {
  const TodoLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<ToDoListCollection>(context).toDoLists;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "My Lists",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          itemCount: todoLists.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Icon(Icons.delete),
                ),
              ),
              onDismissed: (direction) {
                Provider.of<ToDoListCollection>(context, listen: false)
                    .removeToDoList(todoLists[index]);
              },
              direction: DismissDirection.endToStart,
              child: ListTile(
                leading: CategoryIcon(
                    bgColor: CustomColorCollection()
                        .findById(
                          todoLists[index].icon["color"],
                        )
                        .color,
                    iconData: CustomIconCollection()
                        .findById(
                          todoLists[index].icon["id"],
                        )
                        .icon),
                trailing: Text(
                  "0",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                title: Text(todoLists[index].title),
              ),
            );
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ]),
    );
  }
}
