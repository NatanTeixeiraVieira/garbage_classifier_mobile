import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:garbage_classifier_mobile/injection.dart';
import 'package:garbage_classifier_mobile/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cadastro bem-sucedido navega para Home', (tester) async {
    setupDependencies();
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final unique = DateTime.now().microsecondsSinceEpoch;
    await tester.enterText(find.bySemanticsLabel('Nome'), 'Usuário Teste');
    await tester.enterText(
        find.bySemanticsLabel('Email'), 'user_$unique@test.com');
    await tester.enterText(find.bySemanticsLabel('Senha'), '12345678');
    await tester.enterText(find.bySemanticsLabel('CEP'), '12345678');
    await tester.enterText(find.bySemanticsLabel('Rua'), 'Rua X');
    await tester.enterText(find.bySemanticsLabel('Bairro'), 'Centro');
    await tester.enterText(find.bySemanticsLabel('Cidade'), 'Rio');

    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Classificador de Lixo'), findsOneWidget);
  });
}
