import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/database/database_helper.dart';
import 'package:garbage_classifier_mobile/models/user_model.dart';
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
      child: ListView(
        children: [
          PersonalInfoFormSection(
            nameController: _nameController,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const SizedBox(height: 16),
          AddressFormSection(
            cepController: _cepController,
            streetController: _streetController,
            neighborhoodController: _neighborhoodController,
            cityController: _cityController,
            onCepChanged: _handleCepChange,
          ),
          const SizedBox(height: 24),
          RegisterActions(
            onRegister: handleRegisterUser,
            onGoToLogin: widget.onGoToLogin,
            buttonAnimationController: _buttonController,
          ),
        ],
      ),
    );
  }
}
