import '../entities/garbage_classification.dart';

abstract interface class IGarbageClassificationRepository {
  Future<GarbageClassification> classifyGarbage(String imagePath);
}
