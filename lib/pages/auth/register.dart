import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuptia/model/user.dart';
import 'package:nuptia/model/userList.dart';
import 'package:provider/provider.dart';

import 'package:nuptia/components/formFieldPersonal.dart';

class Register extends StatelessWidget {
  final bool isProvider;
  const Register({super.key, required this.isProvider});

  @override
  Widget build(BuildContext context) {
    final _users = Provider.of<UserList>(
      context,
      listen: true,
    );
    final _emailFocus = FocusNode();
    final _usernameFocus = FocusNode();
    final _passwordFocus = FocusNode();
    final _confirmPasswordFocus = FocusNode();
    final _formData = Map<String, Object>();

    void setData(String input, data) {
      _formData[data] = input;
    }

    void register() {}

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          heightFactor: MediaQuery.of(context).size.height,
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
                      onReturn: (String data) {
                        setData(data, 'username');
                      },
                    ),
                    Container(
                      height: 24,
                    ),
                    FormFieldPersonal(
                      label: 'Email',
                      node: _emailFocus,
                      onReturn: (String data) {
                        setData(data, 'email');
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
                      height: 24,
                    ),
                    FormFieldPersonal(
                      label: 'Confirmar Senha',
                      node: _confirmPasswordFocus,
                      onReturn: (String data) {
                        setData(data, 'confirmPassword');
                      },
                    ),
                    Container(
                      height: 32,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: register,
                      child: SizedBox(
                          width: null,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  'Registrar'))),
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
                            "Já Possui conta?"),
                        TextButton(
                          child: Text(
                            'Logar-se',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
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
