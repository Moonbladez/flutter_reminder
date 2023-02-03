import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/helpers.dart';
import 'package:reminders/models/common/custom_color_collection.dart';
import 'package:reminders/models/common/custom_icon_collection.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/screens/view_list/view_list_screen.dart';
import 'package:reminders/services/database_service.dart';
import 'package:reminders/shared/category_icon.dart';
import 'package:reminders/shared/dismissible_background.dart';

class TodoLists extends StatelessWidget {
  const TodoLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<ToDoList>>(context);
    final user = Provider.of<User?>(context, listen: false);
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
              background: const DismissibleBackground(),
              onDismissed: (direction) async {
                try {
                  await DatabaseService(uid: user!.uid)
                      .deleteToDoList(todoLists[index])
                      .then(
                        (value) => showSnackBar(context, "List deleted"),
                      );
                } catch (e) {
                  showSnackBar(
                    context,
                    e.toString(),
                  );
                }
              },
              direction: DismissDirection.endToStart,
              child: ListTile(
                onTap: todoLists[index].reminderCount > 0
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewListScreen(
                              todoList: todoLists[index],
                            ),
                          ),
                        );
                      }
                    : null,
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
                  todoLists[index].reminderCount.toString(),
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
