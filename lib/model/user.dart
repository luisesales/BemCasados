import 'package:flutter/material.dart';
import 'dart:convert';

class User with ChangeNotifier {
  final String id;
  final String username;
  final String password;
  final String email;
  final bool isProvider; // False significa usuário comum, true é Fornecedor
  final List<String> favorites;
  final List<String> cart;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.isProvider,
    required this.favorites,
    required this.cart,
  });

  User.fromUser(User user)
      : id = user.id,
        username = user.username,
        password = user.password,
        email = user.email,
        isProvider = user.isProvider,
        favorites = user.favorites,
        cart = user.cart;

  factory User.fromJson(String id, Map<String, dynamic> Json) {
    return User(
      id: id,
      username: Json['username'],
      password: Json['password'],
      email: Json['email'],
      isProvider: Json['isProvider'] ?? false,
      favorites: List<String>.from(json.decode(Json['favorites']) ?? []),
      cart: List<String>.from(json.decode(Json['favorites']) ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'isProvider': isProvider,
      'favorites': jsonEncode(favorites),
      'cart': jsonEncode(cart)
    };
    return data;
  }
}
