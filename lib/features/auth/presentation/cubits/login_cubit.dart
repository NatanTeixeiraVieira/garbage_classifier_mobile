import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/entities/user.dart';
import 'package:garbage_classifier_mobile/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // Usa o call operator do UseCase (padrão comum). Se o seu usecase tiver outro método,
      // ajuste para _loginUseCase.execute(...) ou o nome correto.
      final user = await _loginUseCase(email.trim(), password);
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure('Credenciais inválidas'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
