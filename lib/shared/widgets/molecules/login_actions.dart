import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/animated_button.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/link_text.dart';

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
          text: 'Entrar',
          onPressed: onLogin,
          icon: Icons.login,
          animationController: buttonAnimationController,
        ),
        const SizedBox(height: 16),
        LinkText(
          text: 'Não possui conta? Cadastre-se',
          onTap: onGoToRegister,
          semanticLabel: 'Link para tela de cadastro',
          semanticHint: 'Toque para ir para a tela de cadastro',
        ),
      ],
    );
  }
}
