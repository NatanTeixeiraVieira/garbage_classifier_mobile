import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final IAuthRepository _authRepository;

  RegisterUserUseCase(this._authRepository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
    required String cep,
    required String street,
    required String neighborhood,
    required String city,
  }) async {
    return _authRepository.registerUser(
      name: name,
      email: email,
      password: password,
      cep: cep,
      street: street,
      neighborhood: neighborhood,
      city: city,
    );
  }
}
