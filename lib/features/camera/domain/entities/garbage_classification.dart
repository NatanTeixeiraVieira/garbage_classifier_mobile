class GarbageClassification {
  final String className;
  final double confidence;

  GarbageClassification({
    required this.className,
    required this.confidence,
  });

  factory GarbageClassification.fromMap(Map<String, dynamic> map) {
    final result = map['result'];
    return GarbageClassification(
      className: result['class_name'],
      confidence: result['confidence']?.toDouble() ?? 0.0,
    );
  }
}
