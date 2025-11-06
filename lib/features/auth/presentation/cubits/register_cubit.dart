import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/register_user_usecase.dart';
import '../../domain/usecases/save_session_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase _registerUserUseCase;
  final SaveSessionUseCase _saveSessionUseCase;

  RegisterCubit(this._registerUserUseCase, this._saveSessionUseCase)
      : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String cep,
    required String street,
    required String neighborhood,
    required String city,
  }) async {
    emit(RegisterLoading());

    try {
      final user = await _registerUserUseCase(
        name: name,
        email: email,
        password: password,
        cep: cep,
        street: street,
        neighborhood: neighborhood,
        city: city,
      );
      emit(RegisterSuccess(user));
      // Persist session after successful registration (store user id)
      if (user.id != null) {
        await _saveSessionUseCase(user.id!);
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
