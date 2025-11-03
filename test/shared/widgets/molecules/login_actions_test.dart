import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/shared/widgets/molecules/login_actions.dart';

void main() {
  testWidgets('LoginActions chama callbacks ao tocar', (tester) async {
    late AnimationController controller;
    bool loginTapped = false;
    bool goToRegisterTapped = false;

    await tester.pumpWidget(MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          controller = AnimationController(vsync: const TestVSync());
          return Scaffold(
            body: LoginActions(
              onLogin: () => loginTapped = true,
              onGoToRegister: () => goToRegisterTapped = true,
              buttonAnimationController: controller,
            ),
          );
        },
      ),
    ));

    await tester.tap(find.text('Entrar'));
    await tester.pump();
    expect(loginTapped, isTrue);

    await tester.tap(find.text('Não possui conta? Cadastre-se'));
    await tester.pump();
    expect(goToRegisterTapped, isTrue);

    controller.dispose();
  });
}


