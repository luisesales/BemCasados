import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:BemCasados/components/formFieldPersonal.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  final bool isProvider;
  const Register({super.key, required this.isProvider});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};
  String _errorMessage = '';
  final uuid = Uuid(); // Inicializa o gerador de UUID

  void setData(String input, String data) {
    _formData[data] = input;
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    print('FormData: $_formData'); // Verificar os dados

    if (_formData['username'] == null ||
        _formData['email'] == null ||
        _formData['password'] == null) {
      setState(() {
        _errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    try {
      final uid = uuid.v4(); // Gera um identificador único
      final url =
          'https://bemcasados-a6b2b-default-rtdb.firebaseio.com/users/$uid.json';
      final response = await http.put(
        Uri.parse(url),
        body: json.encode({
          'username': _formData['username'],
          'email': _formData['email'],
          'password': _formData[
              'password'], // Para segurança, não armazene senhas em texto puro.
          'isProvider': widget.isProvider,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(
            '/login'); // Redireciona para a página de login
      } else {
        setState(() {
          _errorMessage = 'Erro de registro: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro de registro: ${e.toString()}';
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
                child: SvgPicture.asset("assets/images/logo.svg"),
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
                            padding: WidgetStatePropertyAll<EdgeInsets>(
                                EdgeInsets.zero),
                          ),
                        ),
                        FormFieldPersonal(
                          label: 'Usuário',
                          node: _usernameFocus,
                          hide: false,
                          onReturn: (String data) {
                            setData(data, 'username');
                            print('Username: $data'); // Adicione este print
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o nome de usuário';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        FormFieldPersonal(
                          label: 'Email',
                          node: _emailFocus,
                          hide: false,
                          onReturn: (String data) {
                            setData(data, 'email');
                            print('Email: $data'); // Adicione este print
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
                          hide: true,
                          onReturn: (String data) {
                            setData(data, 'password');
                            print('Password: $data'); // Adicione este print
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: register,
                          child: SizedBox(
                            width: null,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Registrar-se',
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
                              "Já Possui conta?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              child: Text(
                                'Logar-se',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/login');
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
