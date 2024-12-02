import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String id;
  final String username;
  final String password;
  final String email;
  final bool isProvider; // False significa usuário comum, true é Fornecedor

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.isProvider,
  });

  User.fromUser(User user)
      : id = user.id,
        username = user.username,
        password = user.password,
        email = user.email,
        isProvider = user.isProvider;

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      username: json['username'],
      password: json['password'],
      email: json['email'],
      isProvider: json['isProvider'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'isProvider': isProvider
    };
    return data;
  }
}
