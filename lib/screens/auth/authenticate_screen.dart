import 'package:flutter/material.dart';
import 'package:reminders/screens/auth/sign_in_screen.dart';
import 'package:reminders/screens/auth/sign_up_screen.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  bool _isSignInScreen = true;

  void toggleView() {
    setState(() {
      _isSignInScreen = !_isSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isSignInScreen
          ? SignInScreen(toggleView: toggleView)
          : SignUpScreen(toggleView: toggleView),
    );
  }
}
