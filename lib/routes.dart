import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminders/screens/auth/authenticate_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';

final appRoutes = {
  "/add_list": (context) => const AddListScreen(),
  "/add_reminder": (context) => const AddReminderScreen(),
  "/home": (context) => const HomeScreen(),
};
