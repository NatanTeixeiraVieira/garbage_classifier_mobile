import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/text_field_app.dart';

class PersonalInfoFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  const PersonalInfoFormSection({
    super.key,
    required this.nameController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldApp(
          label: "Nome",
          controller: nameController,
          hint: "Digite seu nome completo",
          validator: (value) =>
              value == null || value.isEmpty ? "Digite o seu nome" : null,
        ),
        const SizedBox(height: 16),
        TextFieldApp(
          label: "Email",
          controller: emailController,
          hint: "Digite seu email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return "Digite seu email";
            if (!value.contains("@") || !value.contains(".")) {
              return "Digite um email válido";
            }
            return null;
          },
        ),
      ],
    );
  }
}
