import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/routes.dart';
import 'package:reminders/screens/auth/authenticate_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';
import 'package:reminders/theme.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return ChangeNotifierProvider<ToDoListCollection>(
      create: (context) => ToDoListCollection(),
      child: MaterialApp(
        title: 'Reminders',
        theme: appTheme,
        routes: appRoutes,
        home: user == null ? const AuthenticateScreen() : const HomeScreen(),
      ),
    );
  }
}
