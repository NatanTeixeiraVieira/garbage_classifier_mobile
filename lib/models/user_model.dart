import 'package:crypto/crypto.dart';
import 'dart:convert';

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String cep;
  final String street;
  final String neighborhood;
  final String city;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cep,
    required this.street,
    required this.neighborhood,
    required this.city,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'cep': cep,
      'street': street,
      'neighborhood': neighborhood,
      'city': city,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      cep: map['cep'],
      street: map['street'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool verifyPassword(String password) {
    return this.password == User.hashPassword(password);
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, city: $city}';
  }
}
