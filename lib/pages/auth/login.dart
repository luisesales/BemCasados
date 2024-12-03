import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuptia/model/user.dart';
import 'package:nuptia/model/userList.dart';
import 'package:provider/provider.dart';

import 'package:nuptia/components/formFieldPersonal.dart';

class Login extends StatelessWidget {
  final bool isProvider;
  const Login({super.key, required this.isProvider});

  @override
  Widget build(BuildContext context) {
    final _users = Provider.of<userList>(
      context,
      listen: true,
    );
    final _usernameFocus = FocusNode();
    final _passwordFocus = FocusNode();
    final _formData = Map<String, Object>();

    void setData(String username, data) {
      _formData[data] = username;
    }

    void login() {}

    return Scaffold(
        body: Container(
            color: Theme.of(context).primaryColor,
            child: Center(
                heightFactor: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Expanded(
                      flex: 1,
                      child: SvgPicture.asset("assets/images/logo.svg")),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 48, right: 48),
                      child: Form(
                        child: ListView(children: [
                          FormFieldPersonal(
                            label: 'Usuário',
                            node: _usernameFocus,
                            onReturn: (String data) {
                              setData(data, 'username');
                            },
                          ),
                          Container(
                            height: 24,
                          ),
                          FormFieldPersonal(
                            label: 'Senha',
                            node: _passwordFocus,
                            onReturn: (String data) {
                              setData(data, 'password');
                            },
                          ),
                          Container(
                            height: 8,
                          ),
                          TextButton(
                            child: Text(
                              'Esqueceu a senha?',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            onPressed: () {},
                          ),
                          Container(
                            height: 8,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(8)),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white),
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
                                  'registrar-se',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  )
                ]))));
  }
}