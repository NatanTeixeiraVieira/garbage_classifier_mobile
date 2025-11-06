import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/pages/register_screen.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/gradient_background.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/organisms/login_form.dart';
import 'package:garbage_classifier_mobile/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_classifier_mobile/injection.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/login_cubit.dart';

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
          child: BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: LoginForm(
              onLoginSuccess: () => _handleLoginSuccess(context),
              onGoToRegister: () => _handleGoToRegister(context),
            ),
          ),
        ),
      ),
    );
  }
}
