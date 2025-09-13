import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      throw Exception("Permissão da câmera negada");
    }

    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {}); // força rebuild quando inicializar
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePictureAndSend() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller!.takePicture();

      setState(() => _isSending = true);

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://aa7a9974d1cf.ngrok-free.app/classify'),
      );

      request.headers.addAll({
        "accept": "application/json",
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          image.path,
        ),
      );

      final response = await request.send();
      print(response);

      setState(() => _isSending = false);

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(respStr);

        final className = jsonResponse['result']['class_name'];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(garbage: className)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao enviar: ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Câmera"),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller!),
                if (_isSending)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton(
                      onPressed: _isSending ? null : _takePictureAndSend,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
