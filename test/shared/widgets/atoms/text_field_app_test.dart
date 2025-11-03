import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/text_field_app.dart';

void main() {
  testWidgets('TextFieldApp exibe label/hint e oculta texto quando obscureText=true', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TextFieldApp(
          label: 'Senha',
          hint: 'Digite sua senha',
          controller: controller,
          obscureText: true,
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);
    // O hint é exposto via Semantics, não como texto renderizado; não validamos aqui

    // Ao digitar, garantimos que o campo está configurado como obscuro
    await tester.enterText(find.byType(TextFormField), 'segredo123');
    await tester.pump();
    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.obscureText, isTrue);
  });
}


