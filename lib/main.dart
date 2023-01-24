import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Reminders',
      theme: appTheme,
      routes: appRoutes,
    );
  }
}
