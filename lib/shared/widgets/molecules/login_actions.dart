import 'package:flutter/material.dart';

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
        // Botão principal de login
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: onLogin,
            icon: const Icon(
              Icons.login,
              size: 20,
            ),
            label: const Text(
              "Entrar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Divisor com texto
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "ou",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Link para registro
        Center(
          child: GestureDetector(
            onTap: onGoToRegister,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                children: [
                  const TextSpan(text: "Não possui conta? "),
                  TextSpan(
                    text: "Cadastre-se",
                    style: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
