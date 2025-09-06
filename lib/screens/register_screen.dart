import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/gradient_background.dart';
import 'package:garbage_classifier_mobile/shared/widgets/organisms/register_form.dart';
import 'package:garbage_classifier_mobile/screens/home_screen.dart';
import 'package:garbage_classifier_mobile/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _handleRegisterSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _handleGoToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: Colors.green[50]!,
      ),
      body: GradientBackground(
        colors: [Colors.green[50]!, Colors.green[200]!],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RegisterForm(
            onRegisterSuccess: () => _handleRegisterSuccess(context),
            onGoToLogin: () => _handleGoToLogin(context),
          ),
        ),
      ),
    );
  }
}
