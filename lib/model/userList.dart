import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuptia/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserList with ChangeNotifier {
  final _baseUrl = 'https://nuptia-c773d-default-rtdb.firebaseio.com/';
  List<User> _userList = [];
  List<User> get users {
    return [..._userList];
  }

  Future<List<User>> fetchUsers() async {
    List<User> users = [];
    try {
      print("Vou acessar a url");
      final response = await http.get(Uri.parse('$_baseUrl/users.json'));
      print("Acessei a url");
      if (response.statusCode == 200) {
        print("Consegui os dados");
        Map<String, dynamic> _userListJson = jsonDecode(response.body);
        _userListJson.forEach((id, user) {
          users.add(User.fromJson(id, user));
        });
        print(users);
        print('\n\n\n\n[ESPAÇO PARA LER DADOS]');
        _userList = users;
        return users;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      print("Aconteceu o erro");
      print(e);
      throw e;
    }
  }

  Future<void> addUser(User user) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/users.json'),
          body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        _userList.add(User(
            id: id,
            username: user.username,
            password: user.password,
            email: user.email,
            isProvider: user.isProvider));
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      var response = await http.put(
          Uri.parse('$_baseUrl/users/${user.id}.json'),
          body: jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        User newUser = User(
            id: id,
            username: user.username,
            password: user.password,
            email: user.email,
            isProvider: user.isProvider);
        _userList.remove(user);
        _userList.add(newUser);
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUser(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final user = User(
        id: hasId
            ? (data['id'] as String?) ?? Random().nextDouble().toString()
            : Random().nextDouble().toString(),
        username: (data['username'] as String?) ?? 'New User',
        password: (data['password'] as String) ??
            Random().nextInt(10 ^ 50).toString(),
        email: (data['email'] as String) ?? 'New Email',
        isProvider: (data['isProvider'] as bool?) ?? false);
    if (hasId) {
      return updateUser(user);
    } else {
      return addUser(user);
    }
  }

  Future<void> removeUser(User user) async {
    try {
      final response =
          await http.delete(Uri.parse('$_baseUrl/users/${user.id}.json'));
      if (response.statusCode == 200) {
        removeUserFromList(user);
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  void removeUserFromList(User user) {
    int index = _userList.indexWhere((p) => p.id == user.id);
    if (index >= 0) {
      _userList.removeWhere((p) => p.id == user.id);
      notifyListeners();
    }
  }
}
