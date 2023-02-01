import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/helpers.dart' as helpers;
import 'package:reminders/models/category.dart';
import 'package:reminders/models/reminder/reminder.dart';

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

          return Card(
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
          );
        },
      ),
    );
  }
}
