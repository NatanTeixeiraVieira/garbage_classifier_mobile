import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/molecules/register_actions.dart';

void main() {
  testWidgets('RegisterActions chama callbacks ao tocar', (tester) async {
    late AnimationController controller;
    bool registerTapped = false;
    bool goToLoginTapped = false;

    await tester.pumpWidget(MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          controller = AnimationController(vsync: const TestVSync());
          return Scaffold(
            body: RegisterActions(
              onRegister: () => registerTapped = true,
              onGoToLogin: () => goToLoginTapped = true,
              buttonAnimationController: controller,
            ),
          );
        },
      ),
    ));

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(registerTapped, isTrue);

    await tester.tap(find.text('Já possui conta? Entrar'));
    await tester.pump();
    expect(goToLoginTapped, isTrue);

    controller.dispose();
  });
}


