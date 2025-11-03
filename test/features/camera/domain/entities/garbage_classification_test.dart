// Testes da entidade GarbageClassification: parsing a partir de Map (JSON)
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/entities/garbage_classification.dart';

void main() {
  // group: agrupa cenários de parsing do método factory
  group('GarbageClassification.fromMap', () {
    test('deve parsear className e confidence corretamente', () {
      // Arrange: mapa simulando resposta da API
      final map = {
        'result': {
          'class_name': 'Recyclable Plastic',
          'confidence': 0.8732,
        }
      };
      // Act
      final gc = GarbageClassification.fromMap(map);
      // Assert
      expect(gc.className, 'Recyclable Plastic');
      expect(gc.confidence, closeTo(0.8732, 0.00001));
    });

    test('confidence nulo deve virar 0.0', () {
      // Arrange
      final map = {
        'result': {
          'class_name': 'Organic',
          'confidence': null,
        }
      };
      // Act
      final gc = GarbageClassification.fromMap(map);
      // Assert
      expect(gc.className, 'Organic');
      expect(gc.confidence, 0.0);
    });
  });
}


