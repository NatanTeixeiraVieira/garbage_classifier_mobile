import '../entities/garbage_classification.dart';
import '../repositories/garbage_classification_repository.dart';

class ClassifyGarbageUseCase {
  final IGarbageClassificationRepository _repository;

  ClassifyGarbageUseCase(this._repository);

  Future<GarbageClassification> call(String imagePath) {
    return _repository.classifyGarbage(imagePath);
  }
}
