import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/text_field_app.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(String)? onEmailChanged;
  final void Function(String)? onPasswordChanged;

  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.onEmailChanged,
    this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldApp(
          label: "Email",
          controller: emailController,
          hint: "Digite seu email",
          keyboardType: TextInputType.emailAddress,
          onChanged: onEmailChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Digite seu email";
            }
            if (!value.contains("@") || !value.contains(".")) {
              return "Digite um email válido";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFieldApp(
          label: "Senha",
          controller: passwordController,
          hint: "Digite sua senha",
          keyboardType: TextInputType.text,
          obscureText: true,
          onChanged: onPasswordChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Digite sua senha";
            }
            if (value.length < 8) {
              return "A senha precisa ter pelo menos 8 caracteres";
            }
            return null;
          },
        ),
      ],
    );
  }
}
