import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reminders/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.toggleView});

  final VoidCallback toggleView;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text("Sign in"))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.network(
                'https://assets10.lottiefiles.com/private_files/lf30_8ry7qrbu.json'),
            Text(
              "Sign Up",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) => value == null ||
                              !value.contains("@") ||
                              !value.contains(".com")
                          ? "Enter a valid email"
                          : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: "Enter email"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(hintText: "Enter password"),
                      obscureText: true,
                      validator: (value) => value!.length < 6
                          ? "Enter a password 6+ chars long"
                          : null,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = await AuthService()
                              .createWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                          if (user != null) {
                            print(user);
                          }
                        }
                      },
                      child: const Text("Sign up"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
