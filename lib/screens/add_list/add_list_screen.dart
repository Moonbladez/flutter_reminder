import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/common/custom_color.dart';
import 'package:reminders/models/common/custom_color_collection.dart';
import 'package:reminders/models/common/custom_icon.dart';
import 'package:reminders/models/common/custom_icon_collection.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  CustomColor _selectedColor = CustomColorCollection().colors.first;
  CustomIcon _selectedIcon = CustomIconCollection().icons.first;

  final TextEditingController _textController = TextEditingController();
  String _listName = "";

  @override
  void initState() {
    _textController.addListener(
      () {
        setState(
          () {
            _listName = _textController.text;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _listName.isEmpty
                ? null
                : () {
                    if (_textController.text.isNotEmpty) {
                      Provider.of<ToDoListCollection>(context, listen: false)
                          .addToDoList(
                        ToDoList(
                          id: DateTime.now().toString(),
                          title: _textController.text,
                          icon: {
                            "id": _selectedIcon.id,
                            "color": _selectedColor.id
                          },
                        ),
                      );

                      Navigator.pop(context);
                    } else {
                      print("throw error");
                    }
                  },
            child: const Text(
              "Add",
            ),
          )
        ],
        title: const Text(
          "New List",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: _selectedColor.color, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              child: Icon(_selectedIcon.icon),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).cardColor),
              padding: const EdgeInsets.all(4),
              child: TextField(
                controller: _textController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                autofocus: true,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    splashRadius: 16,
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                      child: Icon(Icons.clear,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                for (final customColor in CustomColorCollection().colors)
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          _selectedColor = customColor;
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(4.0),
                      width: 50,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: customColor.id == _selectedColor.id
                                ? Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1)
                                : null,
                            color: customColor.color,
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                for (final customIcon in CustomIconCollection().icons)
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          _selectedIcon = customIcon;
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: _selectedIcon.id == customIcon.id
                                ? Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1)
                                : null,
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        child: Icon(customIcon.icon),
                      ),
                    ),
                  )
              ],
            )
          ],
        )),
      ),
    );
  }
}
