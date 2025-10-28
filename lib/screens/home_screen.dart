import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/button.dart';
import 'camera_screen.dart';

class HomeScreen extends StatelessWidget {
  final String garbage;

  const HomeScreen({super.key, this.garbage = ''});

  void _startCamera(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CameraScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Classificador de Lixo",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[800],
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone principal
            Icon(
              Icons.recycling,
              size: 100,
              color: Colors.green[700],
            ),

            const SizedBox(height: 32),

            // Texto principal
            Text(
              "Identifique o tipo de lixo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Use a câmera para classificar resíduos e ajudar na reciclagem.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 48),

            // Botão
            Button(
              icon: Icons.camera_alt_outlined,
              onPressed: () => _startCamera(context),
              text: "Iniciar Escaneamento",
            ),

            if (garbage.isNotEmpty) ...[
              const SizedBox(height: 60),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Text(
                  'O lixo identificado é: $garbage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 40),
            Text(
              '⚠️ As classificações podem conter erros.\nVerifique antes de descartar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
