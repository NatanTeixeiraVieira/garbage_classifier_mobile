import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/home/presentation/pages/home_screen.dart';

void main() {
  testWidgets('HomeScreen renderiza título e botão', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Classificador de Lixo'), findsOneWidget);
    expect(find.text('Escanear'), findsOneWidget);
  });

  testWidgets('HomeScreen mostra mensagem quando garbage não vazio', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(garbage: 'Plastic')));

    expect(find.text('O lixo verificado é Plastic'), findsOneWidget);
  });
}


