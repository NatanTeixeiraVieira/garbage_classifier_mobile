import 'package:flutter/material.dart';
import '../atoms/animated_button.dart';
import '../atoms/link_text.dart';

class LoginActions extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onGoToRegister;
  final AnimationController buttonAnimationController;

  const LoginActions({
    super.key,
    required this.onLogin,
    required this.onGoToRegister,
    required this.buttonAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedButton(
          text: "Entrar",
          icon: Icons.login,
          onPressed: onLogin,
          animationController: buttonAnimationController,
        ),
        const SizedBox(height: 12),
        Center(
          child: LinkText(
            text: "Não possui conta? Cadastre-se",
            onTap: onGoToRegister,
            semanticLabel: "Não possui conta? Cadastre-se",
            semanticHint: "Clique para ir para a tela de cadastro",
          ),
        ),
      ],
    );
  }
}
