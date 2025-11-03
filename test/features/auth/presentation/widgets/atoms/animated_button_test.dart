import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/animated_button.dart';

void main() {
  testWidgets('AnimatedButton chama onPressed ao tocar', (tester) async {
    final controller = AnimationController(vsync: const TestVSync(), duration: const Duration(milliseconds: 100));
    var tapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AnimatedButton(
          text: 'Cadastrar',
          icon: Icons.person_add,
          onPressed: () => tapped = true,
          animationController: controller,
        ),
      ),
    ));

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(tapped, isTrue);

    controller.dispose();
  });
}


