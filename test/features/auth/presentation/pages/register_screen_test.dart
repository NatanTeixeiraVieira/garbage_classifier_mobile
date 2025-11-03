import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/register_cubit.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/pages/register_screen.dart';

class _MockRegisterCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  late _MockRegisterCubit cubit;

  setUp(() {
    cubit = _MockRegisterCubit();
    whenListen(cubit, const Stream<RegisterState>.empty(), initialState: RegisterInitial());
  });

  Widget _wrap(Widget child) {
    return MaterialApp(
      home: BlocProvider<RegisterCubit>.value(value: cubit, child: child),
    );
  }

  testWidgets('navega para Home quando estado RegisterSuccess é emitido', (tester) async {
    final user = User(
      id: 1,
      name: 'Test',
      email: 'test@test.com',
      password: 'hash',
      cep: '12345678',
      street: 'Rua',
      neighborhood: 'Bairro',
      city: 'Cidade',
    );

    whenListen(
      cubit,
      Stream<RegisterState>.fromIterable([
        RegisterLoading(),
        RegisterSuccess(user),
      ]),
      initialState: RegisterInitial(),
    );

    await tester.pumpWidget(_wrap(const RegisterScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Classificador de Lixo'), findsOneWidget);
  });
}


