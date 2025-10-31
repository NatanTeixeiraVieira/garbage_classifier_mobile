part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {}

class CameraInitializing extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;

  CameraReady(this.controller);

  @override
  List<Object?> get props => [controller];
}

class CameraError extends CameraState {
  final String message;

  CameraError(this.message);

  @override
  List<Object?> get props => [message];
}

class ClassifyingGarbage extends CameraState {}

class GarbageClassified extends CameraState {
  final GarbageClassification result;

  GarbageClassified(this.result);

  @override
  List<Object?> get props => [result];
}

class ClassificationError extends CameraState {
  final String message;

  ClassificationError(this.message);

  @override
  List<Object?> get props => [message];
}
