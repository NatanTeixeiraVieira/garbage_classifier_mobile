import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/database/database_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../molecules/personal_info_form_section.dart';
import '../molecules/address_form_section.dart';
import '../molecules/register_actions.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onGoToLogin;

  const RegisterForm({
    super.key,
    required this.onRegisterSuccess,
    required this.onGoToLogin,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

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

  void handleRegisterUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _dbHelper.registerUser(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            cep: _cepController.text,
            street: _streetController.text,
            neighborhood: _neighborhoodController.text,
            city: _cityController.text);
        widget.onRegisterSuccess();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
        return;
      }
    }
  }

  void _handleCepChange(String value) {
    setState(() {});
    if (value.length == 8) {
      _fetchAddress(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção de informações pessoais
          _buildSectionCard(
            title: "Informações Pessoais",
            icon: Icons.person_outline,
            child: PersonalInfoFormSection(
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Seção de endereço
          _buildSectionCard(
            title: "Endereço",
            icon: Icons.location_on_outlined,
            child: AddressFormSection(
              cepController: _cepController,
              streetController: _streetController,
              neighborhoodController: _neighborhoodController,
              cityController: _cityController,
              onCepChanged: _handleCepChange,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Ações
          RegisterActions(
            onRegister: handleRegisterUser,
            onGoToLogin: widget.onGoToLogin,
            buttonAnimationController: _buttonController,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho da seção
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.green[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          
          // Conteúdo da seção
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
