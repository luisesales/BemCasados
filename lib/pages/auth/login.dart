import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuptia/model/user.dart';
import 'package:nuptia/model/userList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nuptia/components/formFieldPersonal.dart';

class Login extends StatefulWidget {
  final bool isProvider;
  const Login({super.key, required this.isProvider});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<UserList>(
      context,
      listen: true,
    );
    late Future<List<User>> _users = _provider.fetchUsers();
    final _usernameFocus = FocusNode();
    final _passwordFocus = FocusNode();
    final _formData = Map<String, Object>();
    bool _rememberMe = false;

    void setUsername(String input) {
      _formData["username"] = input;
    }

    void setPassword(String input) {
      _formData["password"] = input;
    }

    _loadUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _formData['username'] = prefs.getString('email_username') ?? '';
        _formData['password'] = prefs.getString('password') ?? '';
        _rememberMe = prefs.getBool('remember_me') ?? false;
      });
    }

    _saveUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email_username', _usernameFocus.toString());
      prefs.setString('password', _passwordFocus.toString());
      prefs.setBool('remember_me', _rememberMe);
    }

    _clearUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email_username');
      prefs.remove('password');
      prefs.setBool('remember_me', false);
    }

    void login() {
      setState(() {
        final List<User> userList = _provider.users;
        for (int i = 0; i < userList.length; i++) {
          if ((_formData['username'] == userList[i].username ||
                  _formData['username'] == userList[i].email) &&
              _formData['password'] == userList[i].password) {
            if (_rememberMe) {
              _saveUserData();
            } else {
              _clearUserData();
            }
            Navigator.of(context).pushNamed('/home');
            return;
          }
        }
      });
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(children: [
            Expanded(
                flex: 1, child: SvgPicture.asset("assets/images/logo.svg")),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 48, right: 48),
                child: Form(
                  child: ListView(children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).popAndPushNamed('/select-user');
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.white, size: 16),
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
                        padding:
                            WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
                      ),
                    ),
                    FormFieldPersonal(
                      label: 'Usuário',
                      node: _usernameFocus,
                      hide: false,
                      onReturn: (String data) {
                        setUsername(data);
                      },
                    ),
                    Container(
                      height: 24,
                    ),
                    FormFieldPersonal(
                      label: 'Senha',
                      node: _passwordFocus,
                      hide: true,
                      onReturn: (String data) {
                        setPassword(data);
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text(
                          "Lembrar de mim",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    Container(
                      height: 8,
                    ),
                    TextButton(
                      child: Text(
                        'Esqueceu a senha?',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgot-password');
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: login,
                      child: SizedBox(
                          width: null,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  'Login'))),
                    ),
                    Container(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Text(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            "Não Possui conta?"),
                        TextButton(
                          child: Text(
                            'Registrar-se',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
