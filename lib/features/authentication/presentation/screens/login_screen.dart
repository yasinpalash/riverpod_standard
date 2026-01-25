import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/auth_field.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  static const routeName = '/loginScreen';
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController(
    text: 'emilys',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'emilyspass',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Login to continue",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              AuthField(hintText: 'Username', controller: usernameController),
              AuthField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
