import 'package:nuptia/components/formFieldPersonal.dart';
import 'package:nuptia/model/userList.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  final bool isProvider;
  const ForgotPassword({super.key, required this.isProvider});

  @override
  Widget build(BuildContext context) {
    final _users = Provider.of<UserList>(
      context,
      listen: true,
    );
    final _emailFocus = FocusNode();
    final _formData = Map<String, Object>();

    void setData(String username, data) {
      _formData[data] = username;
    }

    void changePassword() {}
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          heightFactor: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  flex: 1, child: SvgPicture.asset("assets/images/logo.svg")),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(left: 48, right: 48),
                  child: Form(
                    child: ListView(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "Voltar ao login",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                            padding: WidgetStatePropertyAll<EdgeInsets>(
                                EdgeInsets.zero),
                          ),
                        ),
                        FormFieldPersonal(
                          label: 'Email',
                          node: _emailFocus,
                          hide: false,
                          onReturn: (String data) {
                            setData(data, 'username');
                          },
                        ),
                        Container(
                          height: 32,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: changePassword,
                          child: SizedBox(
                              width: null,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      'Trocar Senha'))),
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
