import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/login_user_usecase.dart';

class _MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late _MockAuthRepository repo;
  late LoginUserUseCase usecase;

  setUp(() {
    repo = _MockAuthRepository();
    usecase = LoginUserUseCase(repo);
  });

  test('deve delegar ao repositório e retornar User quando credenciais válidas',
      () async {
    final user = User(
      id: 1,
      name: 'John',
      email: 'john@doe.com',
      password: 'hash',
      cep: '12345678',
      street: 'Rua A',
      neighborhood: 'Bairro',
      city: 'Cidade',
    );

    when(() => repo.loginUser('john@doe.com', '12345678'))
        .thenAnswer((_) async => user);

    final result = await usecase('john@doe.com', '12345678');
    expect(result, isA<User>());
    expect(result?.email, 'john@doe.com');
  });

  test('deve retornar null quando repositório retornar null', () async {
    when(() => repo.loginUser('x@y.com', 'bad')).thenAnswer((_) async => null);

    final result = await usecase('x@y.com', 'bad');
    expect(result, isNull);
  });
}
