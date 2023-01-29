import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/routes.dart';
import 'package:reminders/theme.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToDoListCollection>(
      create: (context) => ToDoListCollection(),
      child: MaterialApp(
        title: 'Reminders',
        theme: appTheme,
        routes: appRoutes,
      ),
    );
  }
}
