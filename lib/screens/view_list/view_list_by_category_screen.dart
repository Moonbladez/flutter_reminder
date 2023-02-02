import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/helpers.dart' as helpers;
import 'package:reminders/models/category.dart';
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/models/todo_list/todo_list.dart';

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
              WriteBatch batch = FirebaseFirestore.instance.batch();
              final user = Provider.of<User?>(context, listen: false);
              final toDoLists =
                  Provider.of<List<ToDoList>>(context, listen: false);
              final toDoListForReminder = toDoLists.firstWhere(
                (list) => list.id == reminder.list["id"],
              );

              final remidnerRef = FirebaseFirestore.instance
                  .collection("users")
                  .doc(user?.uid)
                  .collection("reminders")
                  .doc(reminder.id);

              final listRef = FirebaseFirestore.instance
                  .collection("users")
                  .doc(user?.uid)
                  .collection("todo_lists")
                  .doc(
                    reminder.list["id"],
                  );

              batch.delete(remidnerRef);
              batch.update(
                listRef,
                {"reminder_count": toDoListForReminder.reminderCount - 1},
              );

              try {
                batch.commit();
              } catch (e) {
                print(e);
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
