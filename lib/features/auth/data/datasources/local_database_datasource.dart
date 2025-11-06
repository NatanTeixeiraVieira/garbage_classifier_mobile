import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract interface class ILocalDatabaseDataSource {
  Future<Database> get database;
  Future<int> insertUser(Map<String, dynamic> userData);
  Future<Map<String, dynamic>?> getUserByEmail(String email);
  Future<Map<String, dynamic>?> getUserById(int id);
  Future<List<Map<String, dynamic>>> getAllUsers();
  Future<void> close();
  // session management
  Future<void> setCurrentUserId(int id);
  Future<int?> getCurrentUserId();
  Future<void> clearCurrentUserId();
}

class LocalDatabaseDataSource implements ILocalDatabaseDataSource {
  static final LocalDatabaseDataSource instance =
      LocalDatabaseDataSource._privateConstructor();
  static Database? _database;

  LocalDatabaseDataSource._privateConstructor();

  @override
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
      // session table for storing small app session values
      await db.execute('''
        CREATE TABLE session(
          key TEXT PRIMARY KEY,
          value TEXT
        )
      ''');
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
    // create session table
    await db.execute('''
      CREATE TABLE session(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  @override
  Future<int> insertUser(Map<String, dynamic> userData) async {
    final db = await database;
    try {
      return await db.insert('users', userData);
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw Exception('Este email já está cadastrado');
      }
      throw Exception('Erro ao cadastrar usuário: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.toLowerCase().trim()],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return results.first;
  }

  @override
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return results.first;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return db.query('users', orderBy: 'created_at DESC');
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  // --- session methods
  @override
  Future<void> setCurrentUserId(int id) async {
    final db = await database;
    await db.insert(
      'session',
      {'key': 'current_user_id', 'value': id.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int?> getCurrentUserId() async {
    final db = await database;
    final results = await db.query(
      'session',
      where: 'key = ?',
      whereArgs: ['current_user_id'],
      limit: 1,
    );
    if (results.isEmpty) return null;
    final v = results.first['value'] as String?;
    if (v == null) return null;
    return int.tryParse(v);
  }

  @override
  Future<void> clearCurrentUserId() async {
    final db = await database;
    await db
        .delete('session', where: 'key = ?', whereArgs: ['current_user_id']);
  }
}
