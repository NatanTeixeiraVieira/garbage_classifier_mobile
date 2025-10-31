import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'password_hash_service.dart';

class Sha256PasswordService implements IPasswordHashService {
  @override
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  bool verifyPassword(String hashedPassword, String password) {
    return hashedPassword == hashPassword(password);
  }
}
