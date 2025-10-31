import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/garbage_classification.dart';
import '../../domain/repositories/garbage_classification_repository.dart';

class GarbageClassificationRepository
    implements IGarbageClassificationRepository {
  final String baseUrl;

  GarbageClassificationRepository({
    required this.baseUrl,
  });

  @override
  Future<GarbageClassification> classifyGarbage(String imagePath) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/classify'),
    );

    request.headers.addAll({
      "accept": "application/json",
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imagePath,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(respStr);
      return GarbageClassification.fromMap(jsonResponse);
    } else {
      throw Exception('Failed to classify garbage: ${response.statusCode}');
    }
  }
}
