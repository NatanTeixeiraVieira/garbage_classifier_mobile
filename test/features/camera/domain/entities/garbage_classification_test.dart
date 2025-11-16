import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/entities/garbage_classification.dart';

void main() {
  group('GarbageClassification.fromMap', () {
    test('deve parsear className e confidence corretamente', () {
      final map = {
        'result': {
          'class_name': 'Recyclable Plastic',
          'confidence': 0.8732,
        }
      };
      final gc = GarbageClassification.fromMap(map);
      expect(gc.className, 'Recyclable Plastic');
      expect(gc.confidence, closeTo(0.8732, 0.00001));
    });

    test('confidence nulo deve virar 0.0', () {
      final map = {
        'result': {
          'class_name': 'Organic',
          'confidence': null,
        }
      };
      final gc = GarbageClassification.fromMap(map);
      expect(gc.className, 'Organic');
      expect(gc.confidence, 0.0);
    });
  });
}
