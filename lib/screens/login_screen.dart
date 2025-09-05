import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/screens/home_screen.dart';
import 'package:garbage_classifier_mobile/screens/register_screen.dart';
import 'package:garbage_classifier_mobile/screens/widgets/atoms/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

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

  void _login() async {
    _buttonController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _buttonController.reverse();

    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.green[50],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.green[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Digite seu email";
                      if (!value.contains("@") || !value.contains(".")) {
                        return "Digite um email válido";
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) => value != null && value.length < 8
                        ? "A senha precisa ter pelo menos 8 caracteres"
                        : null,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _login,
                  child: AnimatedBuilder(
                    animation: _buttonController,
                    builder: (context, child) {
                      double scale = 1 - _buttonController.value;
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Button(
                      icon: Icons.login,
                      onPressed: _login,
                      text: "Entrar",
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Não possui conta? Cadastre-se",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
