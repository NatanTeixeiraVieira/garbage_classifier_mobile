import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startCamera(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text("Futuramente vai abrir a câmera para classificar o lixo")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: Colors.green[50]!,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.green[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.recycling,
              size: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              "Classificador de Lixo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Use a câmera para identificar o tipo de lixo e contribuir com a reciclagem!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            Button(
              icon: Icons.camera_alt,
              onPressed: () => _startCamera(context),
              text: "Escanear",
            )
          ],
        ),
      ),
    );
  }
}
