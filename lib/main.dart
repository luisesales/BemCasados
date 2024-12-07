import 'package:flutter/material.dart';
import 'package:nuptia/pages/auth/login.dart';
import 'package:nuptia/pages/auth/selectUser.dart';
import 'package:nuptia/pages/auth/register.dart';
import 'package:nuptia/pages/auth/forgotPassword.dart';
import 'package:nuptia/pages/auth/splashScreen.dart';
import 'package:nuptia/pages/auth/welcomeScreen.dart'; // Certifique-se de ter a tela de bem-vindo

import 'package:nuptia/model/userList.dart';
import 'package:nuptia/pages/home/home.dart';
import 'package:nuptia/pages/marketplace/marketplace.dart'; // Importando a página do marketplace
import 'package:provider/provider.dart';
import 'package:nuptia/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isProvider = false; // Inicialize a variável

  void selectUser(bool user) {
    setState(() {
      isProvider = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserList(),
      child: MaterialApp(
        title: 'Meu Casório Club',
        theme: ThemeData(
            fontFamily: 'Inter',
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Color.fromRGBO(213, 29, 72, 100),
                surface: Color.fromRGBO(184, 184, 184, 70)),
            textTheme: TextTheme(
              headlineSmall: TextStyle(
                  fontSize: 8, color: Color.fromRGBO(56, 31, 126, 100)),
              headlineMedium: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(56, 31, 126, 100)),
              headlineLarge: TextStyle(
                  fontSize: 24, color: Color.fromRGBO(56, 31, 126, 100)),
              labelSmall: TextStyle(
                  fontSize: 8, color: Color.fromRGBO(153, 53, 53, 100)),
              labelMedium: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(153, 53, 53, 100)),
              labelLarge: TextStyle(
                  fontSize: 24, color: Color.fromRGBO(153, 53, 53, 100)),
            )),
        home: SplashScreen(), // Primeira tela é a SplashScreen
        routes: {
          Routes.HOME_SCREEN: (context) => HomeScreen(),
          Routes.WELCOME_SCREEN: (context) =>
              WelcomeScreen(), // Tela de Bem-Vindo
          Routes.SELECT_USER: (context) => SelectUser(onSelected: selectUser),
          Routes.LOGIN: (context) => Login(isProvider: isProvider),
          Routes.FORGOT_PASSWORD: (context) =>
              ForgotPassword(isProvider: isProvider),
          Routes.REGISTER: (context) => Register(isProvider: isProvider),
          '/home': (context) =>
              HomeScreen(), // Certifique-se de que isso está correto
          '/login': (context) => Login(isProvider: isProvider),
          '/marketplace': (context) =>
              MarketplacePage(), // Rota para MarketplacePage
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
