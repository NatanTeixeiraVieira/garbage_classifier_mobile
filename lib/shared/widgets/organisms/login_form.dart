import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/database/database_helper.dart';
import '../molecules/login_form_section.dart';
import '../molecules/login_actions.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onGoToRegister;

  const LoginForm({
    super.key,
    required this.onLoginSuccess,
    required this.onGoToRegister,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final isLoginSuccess = await _dbHelper.loginUser(
          _emailController.text, _passwordController.text);
      if (isLoginSuccess != null) {
        widget.onLoginSuccess();
        _emailController.clear();
        _passwordController.clear();
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login ou senha inválidos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card do formulário
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LoginFormSection(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Ações
          LoginActions(
            onLogin: _handleLogin,
            onGoToRegister: widget.onGoToRegister,
            buttonAnimationController: _buttonController,
          ),
        ],
      ),
    );
  }
}
