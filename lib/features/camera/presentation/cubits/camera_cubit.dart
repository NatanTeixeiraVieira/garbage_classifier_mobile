import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/garbage_classification.dart';
import '../../domain/usecases/classify_garbage_usecase.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  final ClassifyGarbageUseCase _classifyGarbageUseCase;
  CameraController? _controller;

  CameraCubit(this._classifyGarbageUseCase) : super(CameraInitial());

  Future<void> initializeCamera() async {
    emit(CameraInitializing());

    try {
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        emit(CameraError("Permissão da câmera negada"));
        return;
      }

      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      emit(CameraReady(_controller!));
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }

  Future<void> takePictureAndClassify() async {
    if (_controller == null) {
      emit(CameraError("Câmera não inicializada"));
      return;
    }

    try {
      emit(ClassifyingGarbage());

      final image = await _controller!.takePicture();
      final result = await _classifyGarbageUseCase(image.path);

      emit(GarbageClassified(result));
    } catch (e) {
      emit(ClassificationError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
