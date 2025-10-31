import '../entities/user.dart';

abstract interface class IAuthRepository {
  Future<User> registerUser({
    required String name,
    required String email,
    required String password,
    required String cep,
    required String street,
    required String neighborhood,
    required String city,
  });

  Future<User?> loginUser(String email, String password);
  Future<User?> getUserByEmail(String email);
  Future<User?> getUserById(int id);
  Future<List<User>> getAllUsers();
  Future<bool> emailExists(String email);
}
