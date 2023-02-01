import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/category.dart';
import 'package:reminders/models/category_collection.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/screens/add_reminder/select_reminder_category_screen.dart';
import 'package:reminders/screens/add_reminder/select_reminder_list_screen.dart';
import 'package:reminders/shared/category_icon.dart';
import "package:intl/intl.dart";

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String _title = "";
  ToDoList? _selectedList;
  Category _selectedCategory = CategoryCollection().categories[0];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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

  _updateSelectedList(ToDoList list) {
    setState(
      () {
        _selectedList = list;
      },
    );
  }

  _updateSelectedCategory(Category category) {
    setState(
      () {
        _selectedCategory = category;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _toDoLists = Provider.of<List<ToDoList>>(context);

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectReminderListScreen(
                            selectedList: _selectedList != null
                                ? _selectedList!
                                : _toDoLists.first,
                            toDoList: _toDoLists,
                            selectedListCallback: _updateSelectedList,
                          ),
                      fullscreenDialog: true),
                );
              },
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CategoryIcon(
                      bgColor: Colors.blueAccent,
                      iconData: Icons.calendar_today),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(_selectedList != null
                      ? _selectedList!.title
                      : _toDoLists.first.title),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Text(
                "Category",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectReminderCategoryScreen(
                            selectedCategory: _selectedCategory,
                            selectedCategoryCallback: _updateSelectedCategory,
                          ),
                      fullscreenDialog: true),
                );
              },
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CategoryIcon(
                      bgColor: _selectedCategory.icon.bgColor,
                      iconData: _selectedCategory.icon.iconData),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(_selectedCategory.name),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Text(
                "Date",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CategoryIcon(
                      bgColor: Colors.teal,
                      iconData: CupertinoIcons.calendar_badge_plus),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(_selectedDate != null
                      ? DateFormat.yMMMd().format(_selectedDate!).toString()
                      : "Select Date"),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Text(
                "Time",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(
                    () {
                      _selectedTime = pickedTime;
                    },
                  );
                }
              },
              tileColor: Theme.of(context).cardColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CategoryIcon(
                      bgColor: Colors.pink, iconData: CupertinoIcons.clock),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(_selectedTime != null
                      ? _selectedTime!.format(context).toString()
                      : "select time"),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
