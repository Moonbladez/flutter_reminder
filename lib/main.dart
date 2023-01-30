import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/firebase_options.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/routes.dart';
import 'package:reminders/screens/wrapper.dart';
import 'package:reminders/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text('Nothing');
        }
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            initialData: FirebaseAuth.instance.currentUser,
            child: const Wrapper(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
