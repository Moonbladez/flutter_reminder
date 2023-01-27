import 'package:flutter/material.dart';
import 'package:reminders/shared/category_icon.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String _title = "";

  @override
  void initState() {
    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _title.isEmpty
                ? null
                : () {
                    print("add to db");
                  },
            child: const Text(
              "Add",
            ),
          )
        ],
        title: const Text('New Reminder'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Title"),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Notes"),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              leading: Text(
                "List",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CategoryIcon(
                      bgColor: Colors.blueAccent,
                      iconData: Icons.calendar_today),
                  SizedBox(
                    width: 8,
                  ),
                  Text("New List"),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Text(
                "Schedule",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CategoryIcon(
                      bgColor: Colors.blueAccent,
                      iconData: Icons.calendar_today),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Scheduled"),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
