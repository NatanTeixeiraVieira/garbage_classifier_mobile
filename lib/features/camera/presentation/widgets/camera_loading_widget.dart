import 'package:flutter/material.dart';

class CameraLoadingWidget extends StatelessWidget {
  const CameraLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Inicializando câmera...',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
