import 'package:garbage_classifier_mobile/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL,
          cep TEXT NOT NULL,
          street TEXT NOT NULL,
          neighborhood TEXT NOT NULL,
          city TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        )
      ''');

      await db.execute('CREATE INDEX idx_users_email ON users(email)');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        cep TEXT NOT NULL,
        street TEXT NOT NULL,
        neighborhood TEXT NOT NULL,
        city TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    try {
      return await db.insert('users', user.toMap());
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw Exception('Este email já está cadastrado');
      }
      throw Exception('Erro ao cadastrar usuário: $e');
    }
  }

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

    final existingUser = await getUserByEmail(email);
    if (existingUser != null) {
      throw Exception('Este email já está cadastrado');
    }

    final user = User(
      name: name.trim(),
      email: email.toLowerCase().trim(),
      password: User.hashPassword(password),
      cep: cep,
      street: street.trim(),
      neighborhood: neighborhood.trim(),
      city: city.trim(),
    );

    final userId = await insertUser(user);

    return User(
      id: userId,
      name: user.name,
      email: user.email,
      password: user.password,
      cep: user.cep,
      street: user.street,
      neighborhood: user.neighborhood,
      city: user.city,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.toLowerCase().trim()],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return User.fromMap(results.first);
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return User.fromMap(results.first);
  }

  Future<User?> loginUser(String email, String password) async {
    final user = await getUserByEmail(email);
    if (user == null) return null;

    if (user.verifyPassword(password)) {
      return user;
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final results = await db.query('users', orderBy: 'created_at DESC');

    return results.map((map) => User.fromMap(map)).toList();
  }

  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
