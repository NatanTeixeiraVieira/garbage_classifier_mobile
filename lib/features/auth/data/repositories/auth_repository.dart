import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_database_datasource.dart';
import '../services/password_hash_service.dart';

class AuthRepository implements IAuthRepository {
  final ILocalDatabaseDataSource _localDataSource;
  final IPasswordHashService _passwordHashService;

  AuthRepository(this._localDataSource, this._passwordHashService);

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Future<User> registerUser({
    required String name,
    required String email,
    required String password,
    required String cep,
    required String street,
    required String neighborhood,
    required String city,
  }) async {
    if (name.trim().length < 2) {
      throw Exception('Nome deve ter pelo menos 2 caracteres');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Email inválido');
    }

    if (password.length < 8) {
      throw Exception('Senha deve ter pelo menos 8 caracteres');
    }

    if (cep.length != 8) {
      throw Exception('CEP deve ter 8 dígitos');
    }

    final user = User(
      name: name.trim(),
      email: email.toLowerCase().trim(),
      password: _passwordHashService.hashPassword(password),
      cep: cep,
      street: street.trim(),
      neighborhood: neighborhood.trim(),
      city: city.trim(),
    );

    final userId = await _localDataSource.insertUser(user.toMap());
    return user.copyWith(id: userId);
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    final userData = await _localDataSource.getUserByEmail(email);
    if (userData == null) return null;

    final user = User.fromMap(userData);
    if (_passwordHashService.verifyPassword(user.password, password)) {
      return user;
    }
    return null;
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final userData = await _localDataSource.getUserByEmail(email);
    if (userData == null) return null;
    return User.fromMap(userData);
  }

  @override
  Future<User?> getUserById(int id) async {
    final userData = await _localDataSource.getUserById(id);
    if (userData == null) return null;
    return User.fromMap(userData);
  }

  @override
  Future<List<User>> getAllUsers() async {
    final usersData = await _localDataSource.getAllUsers();
    return usersData.map((userData) => User.fromMap(userData)).toList();
  }

  @override
  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }
}
