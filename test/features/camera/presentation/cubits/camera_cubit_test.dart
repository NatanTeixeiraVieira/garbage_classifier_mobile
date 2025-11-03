// Testes do CameraCubit: valida estados quando não inicializado e props do estado final
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/entities/garbage_classification.dart';
import 'package:garbage_classifier_mobile/features/camera/domain/usecases/classify_garbage_usecase.dart';
import 'package:garbage_classifier_mobile/features/camera/presentation/cubits/camera_cubit.dart';

class _MockClassifyUseCase extends Mock implements ClassifyGarbageUseCase {}

void main() {
  late _MockClassifyUseCase usecase;

  setUp(() {
    // setUp: recria o mock do use case a cada teste
    usecase = _MockClassifyUseCase();
  });

  blocTest<CameraCubit, CameraState>(
    'takePictureAndClassify sem inicializar deve emitir CameraError',
    build: () => CameraCubit(usecase),
    act: (cubit) => cubit.takePictureAndClassify(), // act: tenta classificar sem inicializar câmera
    expect: () => [isA<CameraError>()], // assert: erro de câmera não inicializada
  );

  test('GarbageClassified state props deve conter result', () {
    // Este teste valida que o estado inclui o resultado na comparação de igualdade
    final result = GarbageClassification(className: 'Paper', confidence: 0.9);
    final state = GarbageClassified(result);
    expect(state.props, contains(result));
  });
}


