import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/camera_cubit.dart';
import '../../domain/entities/garbage_classification.dart';
import '../widgets/camera_error_widget.dart';
import '../widgets/camera_loading_widget.dart';
import '../widgets/camera_preview_widget.dart';
import '../../../home/presentation/pages/home_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  void _handleClassificationSuccess(
      BuildContext context, GarbageClassification result) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(garbage: result.className),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraCubit, CameraState>(
      listener: (context, state) {
        if (state is GarbageClassified) {
          _handleClassificationSuccess(context, state.result);
        } else if (state is ClassificationError || state is CameraError) {
          final message = state is ClassificationError
              ? state.message
              : (state as CameraError).message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Câmera",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey[800],
            elevation: 0,
            centerTitle: true,
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, CameraState state) {
    if (state is CameraInitial) {
      context.read<CameraCubit>().initializeCamera();
      return const CameraLoadingWidget();
    }

    if (state is CameraInitializing) {
      return const CameraLoadingWidget();
    }

    if (state is CameraReady) {
      return Stack(
        children: [
          CameraPreviewWidget(controller: state.controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FloatingActionButton(
                onPressed: () =>
                    context.read<CameraCubit>().takePictureAndClassify(),
                backgroundColor: Colors.green,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      );
    }

    if (state is ClassifyingGarbage) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    if (state is CameraError) {
      return CameraErrorWidget(message: state.message);
    }

    return const CameraErrorWidget(
      message: "Estado não esperado",
    );
  }
}
