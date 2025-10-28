
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static Future<void> salvarResultado(String resultado, String usuarioId) async {
    final dbRef = FirebaseDatabase.instance.ref('historico/$usuarioId').push();
    await dbRef.set({
      'resultado': resultado,
      'data': DateTime.now().toIso8601String(),
    });
  }
}