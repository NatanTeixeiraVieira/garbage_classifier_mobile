import 'package:flutter/material.dart';
import '../atoms/animated_button.dart';
import '../atoms/link_text.dart';

class RegisterActions extends StatelessWidget {
  final VoidCallback onRegister;
  final VoidCallback onGoToLogin;
  final AnimationController buttonAnimationController;

  const RegisterActions({
    super.key,
    required this.onRegister,
    required this.onGoToLogin,
    required this.buttonAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedButton(
          text: "Cadastrar",
          icon: Icons.person_add,
          onPressed: onRegister,
          animationController: buttonAnimationController,
        ),
        const SizedBox(height: 12),
        Center(
          child: LinkText(
            text: "Já possui conta? Entrar",
            onTap: onGoToLogin,
            semanticLabel: "Já possui conta? Entrar",
            semanticHint: "Clique para ir para a tela de login",
          ),
        ),
      ],
    );
  }
}
