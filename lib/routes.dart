import 'package:flutter/material.dart';
import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';

final appRoutes = {
  "/": (context) => HomeScreen(),
  "/add_list": (context) => const AddListScreen(),
};
