import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/atoms/link_text.dart';

void main() {
  testWidgets('LinkText chama onTap ao tocar', (tester) async {
    var tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LinkText(
          text: 'Clique aqui',
          onTap: () => tapped = true,
          semanticLabel: 'link',
          semanticHint: 'toque',
        ),
      ),
    ));

    await tester.tap(find.text('Clique aqui'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}


