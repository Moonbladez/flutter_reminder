import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/routes.dart';
import 'package:reminders/screens/auth/authenticate_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';
import 'package:reminders/services/database_service.dart';
import 'package:reminders/theme.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<ToDoList>>.value(
          value: user != null
              ? DatabaseService(uid: user.uid).toDoListStream()
              : null,
          initialData: const [],
        ),
        StreamProvider<List<Reminder>>.value(
          value: user != null
              ? DatabaseService(uid: user.uid).reminderStream()
              : null,
          initialData: const [],
        )
      ],
      child: MaterialApp(
        title: 'Reminders',
        theme: appTheme,
        routes: appRoutes,
        home: user == null ? const AuthenticateScreen() : const HomeScreen(),
      ),
    );
  }
}
