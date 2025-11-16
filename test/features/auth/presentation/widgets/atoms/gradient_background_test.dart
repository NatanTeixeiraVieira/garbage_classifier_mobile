import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/gradient_background.dart';

void main() {
  testWidgets('GradientBackground envolve o child e aplica gradiente',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GradientBackground(
        colors: [Colors.red, Colors.blue],
        child: Text('conteudo'),
      ),
    ));

    expect(find.text('conteudo'), findsOneWidget);
    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration?;
    expect(decoration, isNotNull);
    expect(decoration!.gradient, isA<LinearGradient>());
  });
}
