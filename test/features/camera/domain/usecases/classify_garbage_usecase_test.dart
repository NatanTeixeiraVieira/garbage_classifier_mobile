import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/entities/garbage_classification.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/repositories/garbage_classification_repository.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/usecases/classify_garbage_usecase.dart';

class _MockRepo extends Mock implements IGarbageClassificationRepository {}

void main() {
  late _MockRepo repo;
  late ClassifyGarbageUseCase usecase;

  setUp(() {
    repo = _MockRepo();
    usecase = ClassifyGarbageUseCase(repo);
  });

  test('deve delegar para o repositório e retornar resultado', () async {
    final expected =
        GarbageClassification(className: 'Plastic', confidence: 0.8);
    when(() => repo.classifyGarbage('path/image.jpg'))
        .thenAnswer((_) async => expected);
    final result = await usecase('path/image.jpg');
    expect(result.className, 'Plastic');
    expect(result.confidence, 0.8);
  });
}
