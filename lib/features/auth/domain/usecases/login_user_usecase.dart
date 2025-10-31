import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUserUseCase {
  final IAuthRepository _authRepository;

  LoginUserUseCase(this._authRepository);

  Future<User?> call(String email, String password) async {
    return _authRepository.loginUser(email, password);
  }
}
