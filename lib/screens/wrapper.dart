import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
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
    final toDoListStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("todo_lists")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (toDoListSnapshot) => ToDoList.fromJson(
                  toDoListSnapshot.data(),
                ),
              )
              .toList(),
        );

    return StreamProvider<List<ToDoList>>.value(
      value: toDoListStream,
      initialData: const [],
      child: MaterialApp(
        title: 'Reminders',
        theme: appTheme,
        routes: appRoutes,
        home: user == null ? const AuthenticateScreen() : const HomeScreen(),
      ),
    );
  }
}
