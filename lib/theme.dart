import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.black),
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: Colors.black,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blueAccent,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    ),
  ),
);
