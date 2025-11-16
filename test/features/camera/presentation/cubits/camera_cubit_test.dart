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
    usecase = _MockClassifyUseCase();
  });

  blocTest<CameraCubit, CameraState>(
    'takePictureAndClassify sem inicializar deve emitir CameraError',
    build: () => CameraCubit(usecase),
    act: (cubit) => cubit.takePictureAndClassify(),
    expect: () => [isA<CameraError>()],
  );

  test('GarbageClassified state props deve conter result', () {
    final result = GarbageClassification(className: 'Paper', confidence: 0.9);
    final state = GarbageClassified(result);
    expect(state.props, contains(result));
  });
}
