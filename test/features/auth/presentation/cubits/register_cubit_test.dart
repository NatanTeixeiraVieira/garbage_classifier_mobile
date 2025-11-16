import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/save_session_usecase.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/register_cubit.dart';

class _MockRegisterUseCase extends Mock implements RegisterUserUseCase {}

class _MockSaveSessionUseCase extends Mock implements SaveSessionUseCase {}

void main() {
  late _MockRegisterUseCase registerUseCase;
  late _MockSaveSessionUseCase saveSessionUseCase;

  setUp(() {
    registerUseCase = _MockRegisterUseCase();
    saveSessionUseCase = _MockSaveSessionUseCase();
  });

  blocTest<RegisterCubit, RegisterState>(
    'emite [Loading, Success] quando cadastro conclui',
    build: () {
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

      when(() => registerUseCase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            cep: any(named: 'cep'),
            street: any(named: 'street'),
            neighborhood: any(named: 'neighborhood'),
            city: any(named: 'city'),
          )).thenAnswer((_) async => user);
      when(() => saveSessionUseCase(user.id ?? 2))
          .thenAnswer((_) async => true);
      return RegisterCubit(registerUseCase, saveSessionUseCase);
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
    expect: () => [isA<RegisterLoading>(), isA<RegisterSuccess>()],
  );

  blocTest<RegisterCubit, RegisterState>(
    'emite [Loading, Failure] quando usecase lança exceção',
    build: () {
      when(() => registerUseCase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            cep: any(named: 'cep'),
            street: any(named: 'street'),
            neighborhood: any(named: 'neighborhood'),
            city: any(named: 'city'),
          )).thenThrow(Exception('erro'));
      return RegisterCubit(registerUseCase, saveSessionUseCase);
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
