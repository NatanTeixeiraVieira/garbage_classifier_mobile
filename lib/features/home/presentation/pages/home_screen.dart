import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/button.dart';
import '../../../camera/presentation/pages/camera_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Início"),
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
        child: SingleChildScrollView(
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
              ),
              if (garbage != '') const SizedBox(height: 50),
              if (garbage != '')
                Text(
                  'O lixo verificado é $garbage',
                  style: const TextStyle(fontSize: 24),
                ),
              const SizedBox(height: 50),
              const Text(
                'Por favor, verifique a veracidade das informações. O sistema pode cometer erros.',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
