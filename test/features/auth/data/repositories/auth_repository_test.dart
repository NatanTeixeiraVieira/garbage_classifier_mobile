// Testes de AuthRepository: validações, hashing e integração com data source
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/data/datasources/local_database_datasource.dart';
import 'package:garbage_classifier_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:garbage_classifier_mobile/features/auth/data/services/password_hash_service.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';

// Mocks: simulam dependências para focar na lógica do repositório
class _MockLocalDb extends Mock implements ILocalDatabaseDataSource {}
class _MockHashService extends Mock implements IPasswordHashService {}

void main() {
  late _MockLocalDb db;
  late _MockHashService hash;
  late AuthRepository repo;

  // setUp: recria mocks e repositório antes de cada teste
  setUp(() {
    db = _MockLocalDb();
    hash = _MockHashService();
    repo = AuthRepository(db, hash);
  });

  // group: cadastro de usuário (validações e fluxo feliz)
  group('registerUser', () {
    test('deve validar nome mínimo', () async {
      expect(
        () => repo.registerUser(
          name: 'A',
          email: 'valid@email.com',
          password: '12345678',
          cep: '12345678',
          street: 'Rua',
          neighborhood: 'Bairro',
          city: 'Cidade',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('deve validar email', () async {
      expect(
        () => repo.registerUser(
          name: 'Ana',
          email: 'email-invalido',
          password: '12345678',
          cep: '12345678',
          street: 'Rua',
          neighborhood: 'Bairro',
          city: 'Cidade',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('deve validar tamanho da senha', () async {
      expect(
        () => repo.registerUser(
          name: 'Ana',
          email: 'ana@example.com',
          password: '1234567',
          cep: '12345678',
          street: 'Rua',
          neighborhood: 'Bairro',
          city: 'Cidade',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('deve validar CEP com 8 dígitos', () async {
      expect(
        () => repo.registerUser(
          name: 'Ana',
          email: 'ana@example.com',
          password: '12345678',
          cep: '1234',
          street: 'Rua',
          neighborhood: 'Bairro',
          city: 'Cidade',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('fluxo feliz: deve inserir usuário e retornar com id', () async {
      when(() => hash.hashPassword('12345678')).thenReturn('hashed');
      when(() => db.insertUser(any())).thenAnswer((_) async => 42);

      final user = await repo.registerUser(
        name: ' Ana ',
        email: 'ANA@EXAMPLE.COM',
        password: '12345678',
        cep: '12345678',
        street: ' Rua X ',
        neighborhood: ' Centro ',
        city: ' Rio ',
      );

      expect(user.id, 42);
      expect(user.email, 'ana@example.com');
      expect(user.street, 'Rua X');
      verify(() => hash.hashPassword('12345678')).called(1);
      verify(() => db.insertUser(any())).called(1);
    });
  });

  // testa o login
  group('loginUser', () {
    Map<String, dynamic> userMap({required String email, required String password}) {
      final now = DateTime.now().millisecondsSinceEpoch;
      return {
        'id': 7,
        'name': 'John',
        'email': email,
        'password': password,
        'cep': '12345678',
        'street': 'Rua',
        'neighborhood': 'Bairro',
        'city': 'Cidade',
        'created_at': now,
        'updated_at': now,
      };
    }

    test('deve retornar null quando usuário não existe', () async {
      when(() => db.getUserByEmail('x@y.com')).thenAnswer((_) async => null);
      final result = await repo.loginUser('x@y.com', 'pass');
      expect(result, isNull);
    });

    test('deve retornar User quando senha confere', () async {
      when(() => db.getUserByEmail('a@b.com'))
          .thenAnswer((_) async => userMap(email: 'a@b.com', password: 'hash'));
      when(() => hash.verifyPassword('hash', 'secret')).thenReturn(true);
      final result = await repo.loginUser('a@b.com', 'secret');
      expect(result, isA<User>());
      expect(result?.email, 'a@b.com');
    });

    test('deve retornar null quando senha não confere', () async {
      when(() => db.getUserByEmail('a@b.com'))
          .thenAnswer((_) async => userMap(email: 'a@b.com', password: 'hash'));
      when(() => hash.verifyPassword('hash', 'wrong')).thenReturn(false);
      final result = await repo.loginUser('a@b.com', 'wrong');
      expect(result, isNull);
    });
  });
// Verifica se email já existe no banco
  group('emailExists', () {
    test('true quando getUserByEmail retorna algo', () async {
      when(() => db.getUserByEmail('e@x.com')).thenAnswer((_) async => {
            'id': 1,
            'name': 'N',
            'email': 'e@x.com',
            'password': 'p',
            'cep': '12345678',
            'street': 's',
            'neighborhood': 'n',
            'city': 'c',
            'created_at': DateTime.now().millisecondsSinceEpoch,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          });
      expect(await repo.emailExists('e@x.com'), isTrue);
    });

    test('false quando getUserByEmail retorna null', () async {
      when(() => db.getUserByEmail('n@x.com')).thenAnswer((_) async => null);
      expect(await repo.emailExists('n@x.com'), isFalse);
    });
  });
}


