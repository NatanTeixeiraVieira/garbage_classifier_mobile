// Testes do LoginCubit: sequência de estados emitidos conforme resultado do use case
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/save_session_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/login_cubit.dart';

class _MockLoginUseCase extends Mock implements LoginUserUseCase {}

class _MockSaveSessionUseCase extends Mock implements SaveSessionUseCase {}

void main() {
  late _MockLoginUseCase loginUseCase;
  late _MockSaveSessionUseCase saveSessionUseCase;

  setUp(() {
    // setUp: cria os mocks dos use cases antes de cada teste
    loginUseCase = _MockLoginUseCase();
    saveSessionUseCase = _MockSaveSessionUseCase();
  });

  blocTest<LoginCubit, LoginState>(
    'emite [Loading, Success] quando login retorna usuário',
    build: () {
      // Arrange: configurar mock para retornar um usuário
      final user = User(
        id: 1,
        name: 'John',
        email: 'john@doe.com',
        password: 'hash',
        cep: '12345678',
        street: 'Rua',
        neighborhood: 'Bairro',
        city: 'Cidade',
      );
      when(() => loginUseCase('john@doe.com', '12345678'))
          .thenAnswer((_) async => user);
      when(() => saveSessionUseCase(user.id ?? 1))
          .thenAnswer((_) async => true);
      return LoginCubit(loginUseCase, saveSessionUseCase);
    },
    act: (cubit) => cubit.login(
        email: ' john@doe.com ', password: '12345678'), // act: dispara a ação
    expect: () =>
        [isA<LoginLoading>(), isA<LoginSuccess>()], // assert: ordem dos estados
  );

  blocTest<LoginCubit, LoginState>(
    'emite [Loading, Failure] quando login retorna null',
    build: () {
      when(() => loginUseCase('x@y.com', 'bad')).thenAnswer((_) async => null);
      return LoginCubit(loginUseCase, saveSessionUseCase);
    },
    act: (cubit) => cubit.login(email: 'x@y.com', password: 'bad'),
    expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
  );

  blocTest<LoginCubit, LoginState>(
    'emite [Loading, Failure] quando usecase lança exceção',
    build: () {
      when(() => loginUseCase(any(), any())).thenThrow(Exception('erro'));
      return LoginCubit(loginUseCase, saveSessionUseCase);
    },
    act: (cubit) => cubit.login(email: 'a@b.com', password: '1'),
    expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
  );
}
