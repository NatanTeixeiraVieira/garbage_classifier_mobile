// Testes do RegisterCubit: estados emitidos no sucesso e falha do cadastro
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/register_cubit.dart';

class _MockRegisterUseCase extends Mock implements RegisterUserUseCase {}

void main() {
  late _MockRegisterUseCase usecase;

  setUp(() {
    // setUp: recria o mock do use case a cada teste
    usecase = _MockRegisterUseCase();
  });

  blocTest<RegisterCubit, RegisterState>(
    'emite [Loading, Success] quando cadastro conclui',
    build: () {
      // Arrange: configurar mock para retornar usuário ao registrar
      final user = User(
        id: 2,
        name: 'Ana',
        email: 'ana@ex.com',
        password: 'hash',
        cep: '12345678',
        street: 'Rua',
        neighborhood: 'Bairro',
        city: 'Cidade',
      );

      when(() => usecase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            cep: any(named: 'cep'),
            street: any(named: 'street'),
            neighborhood: any(named: 'neighborhood'),
            city: any(named: 'city'),
          )).thenAnswer((_) async => user);
      return RegisterCubit(usecase); // build: cria o cubit a ser testado
    },
    act: (cubit) => cubit.register(
      name: 'Ana',
      email: 'ana@ex.com',
      password: '12345678',
      cep: '12345678',
      street: 'Rua',
      neighborhood: 'Bairro',
      city: 'Cidade',
    ),
    expect: () => [isA<RegisterLoading>(), isA<RegisterSuccess>()], // assert: ordem dos estados
  );

  blocTest<RegisterCubit, RegisterState>(
    'emite [Loading, Failure] quando usecase lança exceção',
    build: () {
      when(() => usecase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            cep: any(named: 'cep'),
            street: any(named: 'street'),
            neighborhood: any(named: 'neighborhood'),
            city: any(named: 'city'),
          )).thenThrow(Exception('erro'));
      return RegisterCubit(usecase);
    },
    act: (cubit) => cubit.register(
      name: 'Ana',
      email: 'ana@ex.com',
      password: '12345678',
      cep: '12345678',
      street: 'Rua',
      neighborhood: 'Bairro',
      city: 'Cidade',
    ),
    expect: () => [isA<RegisterLoading>(), isA<RegisterFailure>()],
  );
}


