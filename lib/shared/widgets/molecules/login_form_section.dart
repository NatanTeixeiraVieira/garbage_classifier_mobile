import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/text_field_app.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
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
        
        const SizedBox(height: 16),
        
        // Link "Esqueceu a senha?"
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Funcionalidade em desenvolvimento"),
                ),
              );
            },
            child: Text(
              "Esqueceu a senha?",
              style: TextStyle(
                color: Colors.green[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
