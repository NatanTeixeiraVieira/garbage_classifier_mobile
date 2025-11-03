import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/button.dart';

void main() {
  testWidgets('Button dispara onPressed ao tocar', (tester) async {
    var tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Button(
          icon: Icons.camera_alt,
          text: 'Tap',
          onPressed: () => tapped = true,
        ),
      ),
    ));

    await tester.tap(find.text('Tap'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}


