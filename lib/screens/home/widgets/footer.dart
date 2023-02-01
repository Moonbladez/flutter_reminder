import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/add_reminder/add_reminder_screen.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toDoLists = Provider.of<List<ToDoList>>(context);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: toDoLists.isNotEmpty
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddReminderScreen(),
                          fullscreenDialog: true),
                    );
                  }
                : null,
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Add Reminder'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddListScreen(),
                    fullscreenDialog: true),
              );
            },
            child: const Text('Add List'),
          )
        ],
      ),
    );
  }
}
