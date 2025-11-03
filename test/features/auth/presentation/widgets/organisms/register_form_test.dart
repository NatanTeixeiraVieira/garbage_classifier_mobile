import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/register_cubit.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/organisms/register_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _MockRegisterCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  late _MockRegisterCubit cubit;

  setUp(() {
    cubit = _MockRegisterCubit();
    whenListen(cubit, const Stream<RegisterState>.empty(), initialState: RegisterInitial());
  });

  Widget _wrapWithProviders(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RegisterCubit>.value(
          value: cubit,
          child: child,
        ),
      ),
    );
  }

  testWidgets('envia cadastro quando formulário válido e toca em Cadastrar', (tester) async {
    var onSuccessCalled = false;
    await tester.pumpWidget(_wrapWithProviders(RegisterForm(
      onRegisterSuccess: () => onSuccessCalled = true,
      onGoToLogin: () {},
    )));

    // Preenche os campos
    await tester.enterText(find.bySemanticsLabel('Nome'), 'Usuário Teste');
    await tester.enterText(find.bySemanticsLabel('Email'), 'user@test.com');
    await tester.enterText(find.bySemanticsLabel('Senha'), '12345678');
    await tester.enterText(find.bySemanticsLabel('CEP'), '12345678');
    await tester.enterText(find.bySemanticsLabel('Rua'), 'Rua X');
    await tester.enterText(find.bySemanticsLabel('Bairro'), 'Centro');
    await tester.enterText(find.bySemanticsLabel('Cidade'), 'Rio');

    when(() => cubit.register(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          cep: any(named: 'cep'),
          street: any(named: 'street'),
          neighborhood: any(named: 'neighborhood'),
          city: any(named: 'city'),
        )).thenAnswer((_) async {});

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    verify(() => cubit.register(
          name: 'Usuário Teste',
          email: 'user@test.com',
          password: '12345678',
          cep: '12345678',
          street: 'Rua X',
          neighborhood: 'Centro',
          city: 'Rio',
        )).called(1);

    expect(onSuccessCalled, isFalse); // sucesso depende do estado emitido pelo cubit
  });

  testWidgets('não envia cadastro quando formulário inválido', (tester) async {
    await tester.pumpWidget(_wrapWithProviders(RegisterForm(
      onRegisterSuccess: () {},
      onGoToLogin: () {},
    )));

    // Apenas um campo preenchido, restante vazio
    await tester.enterText(find.bySemanticsLabel('Nome'), 'A');
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    verifyNever(() => cubit.register(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          cep: any(named: 'cep'),
          street: any(named: 'street'),
          neighborhood: any(named: 'neighborhood'),
          city: any(named: 'city'),
        ));
  });
}


