import 'package:flutter/material.dart';

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
        // Botão principal de cadastro
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: onRegister,
            icon: const Icon(
              Icons.person_add,
              size: 20,
            ),
            label: const Text(
              "Criar Conta",
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
        
        // Link para login
        Center(
          child: GestureDetector(
            onTap: onGoToLogin,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                children: [
                  const TextSpan(text: "Já possui conta? "),
                  TextSpan(
                    text: "Entrar",
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
