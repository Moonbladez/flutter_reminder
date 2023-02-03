import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/helpers.dart' as helpers;
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/services/database_service.dart';
import 'package:reminders/shared/dismissible_background.dart';

class ViewListScreen extends StatelessWidget {
  final ToDoList todoList;

  const ViewListScreen({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForList = allReminders
        .where((reminder) => reminder.list["id"] == todoList.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(todoList.title),
      ),
      body: ListView.builder(
        itemCount: remindersForList.length,
        itemBuilder: (context, index) {
          final reminder = remindersForList[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: const DismissibleBackground(),
            onDismissed: (direction) {
              final user = Provider.of<User?>(context, listen: false);

              try {
                DatabaseService(uid: user!.uid)
                    .deleteReminder(reminder, todoList);
                helpers.showSnackBar(context, "Reminder deleted");
              } on Exception catch (e) {
                helpers.showSnackBar(
                  context,
                  e.toString(),
                );
              }
            },
            child: Card(
              child: ListTile(
                title: Text(reminder.title),
                subtitle: reminder.notes != null ? Text(reminder.notes!) : null,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      helpers.formatDate(reminder.dueDate),
                    ),
                    Text(
                      helpers.formatTime(
                        context,
                        reminder.dueTime["hour"],
                        reminder.dueTime["minute"],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
