// Testes unitários do Sha256PasswordService: hashing e verificação de senha
import 'package:flutter_test/flutter_test.dart';
import 'package:garbage_classifier_mobile/features/auth/data/services/sha256_password_service.dart';

void main() {
  // group: agrupa cenários do serviço de hash de senha
  group('Sha256PasswordService', () {
    test('hashPassword deve ser determinístico para a mesma entrada', () {
      final service = Sha256PasswordService();
      final h1 = service.hashPassword('senha-segura');
      final h2 = service.hashPassword('senha-segura');
      expect(h1, h2);
      expect(h1, isNotEmpty);
    });

    test('verifyPassword deve retornar true quando o hash corresponde', () {
      final service = Sha256PasswordService();
      final hash = service.hashPassword('12345678');
      expect(service.verifyPassword(hash, '12345678'), isTrue);
    });

    test('verifyPassword deve retornar false quando o hash não corresponde', () {
      final service = Sha256PasswordService();
      final hash = service.hashPassword('abcdefghi');
      expect(service.verifyPassword(hash, 'outra-senha'), isFalse);
    });
  });
}


