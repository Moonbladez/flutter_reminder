import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminders/models/todo_list/todo_list.dart';

class ToDoListCollection with ChangeNotifier {
  final List<ToDoList> _todoLists = [];

  UnmodifiableListView<ToDoList> get toDoLists =>
      UnmodifiableListView(_todoLists);

  addToDoList(ToDoList list) {
    _todoLists.add(list);
    notifyListeners();
  }

  removeToDoList(ToDoList list) {
    _todoLists.removeWhere((element) => element.id == list.id);
    notifyListeners();
  }
}
