// Testes do LoginCubit: sequência de estados emitidos conforme resultado do use case
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/login_cubit.dart';

class _MockLoginUseCase extends Mock implements LoginUserUseCase {}

void main() {
  late _MockLoginUseCase usecase;

  setUp(() {
    // setUp: cria o mock do use case antes de cada teste
    usecase = _MockLoginUseCase();
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
      when(() => usecase('john@doe.com', '12345678'))
          .thenAnswer((_) async => user);
      return LoginCubit(usecase); // build: cria o cubit a ser testado
    },
    act: (cubit) => cubit.login(email: ' john@doe.com ', password: '12345678'), // act: dispara a ação
    expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()], // assert: ordem dos estados
  );

  blocTest<LoginCubit, LoginState>(
    'emite [Loading, Failure] quando login retorna null',
    build: () {
      when(() => usecase('x@y.com', 'bad')).thenAnswer((_) async => null);
      return LoginCubit(usecase);
    },
    act: (cubit) => cubit.login(email: 'x@y.com', password: 'bad'),
    expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
  );

  blocTest<LoginCubit, LoginState>(
    'emite [Loading, Failure] quando usecase lança exceção',
    build: () {
      when(() => usecase(any(), any())).thenThrow(Exception('erro'));
      return LoginCubit(usecase);
    },
    act: (cubit) => cubit.login(email: 'a@b.com', password: '1'),
    expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
  );
}


