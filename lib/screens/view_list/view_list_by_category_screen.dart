import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/helpers.dart' as helpers;
import 'package:reminders/models/category.dart';
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/services/database_service.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;
  const ViewListByCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == "all")
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.id),
      ),
      body: ListView.builder(
        itemCount: remindersForCategory.length,
        itemBuilder: (context, index) {
          final reminder = remindersForCategory[index];

          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              final user = Provider.of<User?>(context, listen: false);
              final toDoLists =
                  Provider.of<List<ToDoList>>(context, listen: false);
              final toDoListForReminder = toDoLists.firstWhere(
                (list) => list.id == reminder.list["id"],
              );

              try {
                DatabaseService(uid: user!.uid)
                    .deleteReminder(reminder, toDoListForReminder);
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
                  children: [
                    Text(helpers.formatDate(reminder.dueDate)),
                    Text(
                      helpers.formatTime(context, reminder.dueTime["hour"],
                          reminder.dueTime["minute"]),
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
