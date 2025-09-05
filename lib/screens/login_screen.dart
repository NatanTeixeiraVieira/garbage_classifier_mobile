import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/screens/home_screen.dart';
import 'package:garbage_classifier_mobile/screens/register_screen.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/gradient_background.dart';
import 'package:garbage_classifier_mobile/shared/widgets/organisms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLoginSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _handleGoToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.green[50],
      ),
      body: GradientBackground(
        colors: [Colors.green[50]!, Colors.green[200]!],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(
            onLoginSuccess: () => _handleLoginSuccess(context),
            onGoToRegister: () => _handleGoToRegister(context),
          ),
        ),
      ),
    );
  }
}
