import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:garbage_classifier_mobile/screens/home_screen.dart';
import 'package:garbage_classifier_mobile/screens/login_screen.dart';
import 'package:garbage_classifier_mobile/screens/widgets/atoms/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();

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

  Future<void> _fetchAddress(String cep) async {
    try {
      final response =
          await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["erro"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("CEP não encontrado")),
          );
          return;
        }

        setState(() {
          _streetController.text = data["logradouro"] ?? "";
          _neighborhoodController.text = data["bairro"] ?? "";
          _cityController.text = data["localidade"] ?? "";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao buscar CEP: $e")),
      );
    }
  }

  void _registerUser() async {
    _buttonController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _buttonController.reverse();

    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool readOnly = false,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      textField: true,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: Colors.green[50]!,
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
                  label: "Nome",
                  controller: _nameController,
                  hint: "Digite seu nome completo",
                  validator: (value) => value == null || value.isEmpty
                      ? "Digite o seu nome"
                      : null,
                ),
                const SizedBox(height: 16),
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
                  label: "CEP",
                  controller: _cepController,
                  hint: "Digite seu CEP (apenas números)",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value?.length != 8) return "CEP inválido";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                    if (value.length == 8) _fetchAddress(value);
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Rua",
                  controller: _streetController,
                  hint: "Nome da rua",
                  validator: (value) {
                    if ((value?.length ?? 0) < 3) {
                      return "A rua deve ter ao menos 3 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Bairro",
                  controller: _neighborhoodController,
                  hint: "Nome do bairro",
                  validator: (value) {
                    if ((value?.length ?? 0) < 3) {
                      return "O bairro deve ter ao menos 3 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Cidade",
                  controller: _cityController,
                  hint: "Nome da cidade",
                  validator: (value) {
                    if ((value?.length ?? 0) < 3) {
                      return "A cidade deve ter ao menos 3 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Semantics(
                  button: true,
                  label: "Cadastrar",
                  hint: "Clique para criar sua conta",
                  child: GestureDetector(
                    onTap: _registerUser,
                    child: AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, child) {
                        double scale = 1 - _buttonController.value;
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Button(
                        icon: Icons.person_add,
                        onPressed: _registerUser,
                        text: "Cadastrar",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Semantics(
                    button: true,
                    label: "Já possui conta? Entrar",
                    hint: "Clique para ir para a tela de login",
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Já possui conta? Entrar",
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
