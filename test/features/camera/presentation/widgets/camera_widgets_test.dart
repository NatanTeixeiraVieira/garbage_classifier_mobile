import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/camera/presentation/widgets/camera_error_widget.dart';
import 'package:garbage_classifier_mobile/features/camera/presentation/widgets/camera_loading_widget.dart';
import 'package:garbage_classifier_mobile/features/camera/presentation/widgets/camera_preview_widget.dart';

class _FakeController extends Fake implements CameraController {}

void main() {
  testWidgets('CameraErrorWidget exibe ícone e mensagem', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CameraErrorWidget(message: 'erro de camera'),
    ));

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.text('erro de camera'), findsOneWidget);
  });

  testWidgets('CameraLoadingWidget exibe loading e texto', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CameraLoadingWidget(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Inicializando câmera...'), findsOneWidget);
  });

  testWidgets('CameraPreviewWidget requer plugin nativo - coberto em E2E', (tester) async {}, skip: true);
}


