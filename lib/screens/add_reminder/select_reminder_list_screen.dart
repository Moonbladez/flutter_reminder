import 'package:flutter/material.dart';
import 'package:reminders/models/todo_list/todo_list.dart';

class SelectReminderListScreen extends StatelessWidget {
  final List<ToDoList> toDoList;
  final ToDoList? selectedList;
  final Function(ToDoList) selectedListCallback;

  const SelectReminderListScreen(
      {super.key,
      required this.toDoList,
      required this.selectedList,
      required this.selectedListCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select List"),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          final item = toDoList[index];
          return ListTile(
            onTap: () {
              selectedListCallback(item);
              Navigator.pop(context);
            },
            title: Text(item.title),
            trailing: item.title == selectedList?.title
                ? const Icon(Icons.check)
                : null,
          );
        },
      ),
    );
  }
}
