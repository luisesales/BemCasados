import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nuptia/components/formFieldPersonal.dart';
import 'package:provider/provider.dart';
import 'package:nuptia/model/userList.dart';
import 'package:nuptia/model/user.dart';
import 'package:nuptia/utils/routes.dart';

class Login extends StatefulWidget {
  final bool isProvider;
  const Login({super.key, required this.isProvider});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};
  String _errorMessage = '';

  void setData(String input, String data) {
    _formData[data] = input;
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_formData['email'] == null || _formData['password'] == null) {
      setState(() {
        _errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    try {
      final url =
          'https://bemcasados-a6b2b-default-rtdb.firebaseio.com/users.json';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> users = json.decode(response.body);
        User? loggedInUser;

        users.forEach((userId, userData) {
          if (userData['email'] == _formData['email'] &&
              userData['password'] == _formData['password']) {
            loggedInUser = User(
              id: userId,
              username: userData['username'],
              password: userData['password'],
              email: userData['email'],
              isProvider: userData['isProvider'],
            );
          }
        });

        if (loggedInUser != null) {
          final userList = Provider.of<UserList>(context, listen: false);
          userList.setCurrentUser(loggedInUser!);

          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          setState(() {
            _errorMessage = 'Credenciais inválidas.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Erro de login: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro de login: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          heightFactor: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset("assets/images/logobc.svg"),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 48),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed('/select-user');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "Voltar à tela inicial",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                          ),
                        ),
                        FormFieldPersonal(
                          label: 'Email', // Alterado de "Usuário" para "Email"
                          node: _emailFocus,
                          onReturn: (String data) {
                            setData(data, 'email');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        FormFieldPersonal(
                          label: 'Senha',
                          node: _passwordFocus,
                          onReturn: (String data) {
                            setData(data, 'password');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: login,
                          child: SizedBox(
                            width: null,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Column(
                          children: [
                            Text(
                              "Não Possui conta?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              child: Text(
                                'Registrar-se',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/register');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
