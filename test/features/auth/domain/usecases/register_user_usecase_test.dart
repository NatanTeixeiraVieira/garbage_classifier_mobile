import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/register_user_usecase.dart';

class _MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late _MockAuthRepository repo;
  late RegisterUserUseCase usecase;

  setUp(() {
    repo = _MockAuthRepository();
    usecase = RegisterUserUseCase(repo);
  });

  test('deve delegar ao repositório passando todos os parâmetros nomeados', () async {
    final user = User(
      id: 10,
      name: 'Ana',
      email: 'ana@example.com',
      password: 'hash',
      cep: '12345678',
      street: 'Rua X',
      neighborhood: 'Centro',
      city: 'Rio',
    );

    when(() => repo.registerUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          cep: any(named: 'cep'),
          street: any(named: 'street'),
          neighborhood: any(named: 'neighborhood'),
          city: any(named: 'city'),
        )).thenAnswer((_) async => user);

    final result = await usecase(
      name: 'Ana',
      email: 'ana@example.com',
      password: '12345678',
      cep: '12345678',
      street: 'Rua X',
      neighborhood: 'Centro',
      city: 'Rio',
    );

    expect(result.id, 10);
    verify(() => repo.registerUser(
          name: 'Ana',
          email: 'ana@example.com',
          password: '12345678',
          cep: '12345678',
          street: 'Rua X',
          neighborhood: 'Centro',
          city: 'Rio',
        )).called(1);
  });
}


