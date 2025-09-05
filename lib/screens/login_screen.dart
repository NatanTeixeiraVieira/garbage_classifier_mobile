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

  void _performLogin() async {
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      textField: true,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
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
                _buildTextField(
                  label: "Email",
                  controller: _emailController,
                  hint: "Digite seu email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Digite seu email";
                    if (!value.contains("@") || !value.contains(".")) {
                      return "Digite um email válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Senha",
                  controller: _passwordController,
                  hint: "Digite sua senha",
                  obscureText: true,
                  validator: (value) => value != null && value.length < 8
                      ? "A senha precisa ter pelo menos 8 caracteres"
                      : null,
                ),
                const SizedBox(height: 24),
                Semantics(
                  button: true,
                  label: "Entrar",
                  hint: "Clique para fazer login",
                  child: GestureDetector(
                    onTap: _performLogin,
                    child: AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, child) {
                        double scale = 1 - _buttonController.value;
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Button(
                        icon: Icons.login,
                        onPressed: _performLogin,
                        text: "Entrar",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Semantics(
                    button: true,
                    label: "Não possui conta? Cadastre-se",
                    hint: "Clique para ir para a tela de cadastro",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
