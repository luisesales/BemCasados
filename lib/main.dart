import 'package:nuptia/pages/auth/login.dart';
import 'package:nuptia/pages/auth/selectUser.dart';
import 'package:nuptia/pages/auth/register.dart';
import 'package:nuptia/pages/auth/forgotPassword.dart';
import 'package:nuptia/pages/auth/splashScreen.dart';
import 'package:nuptia/pages/auth/welcomeScreen.dart';

import 'package:flutter/material.dart';
import 'package:nuptia/model/userList.dart';
import 'package:provider/provider.dart';
import 'package:nuptia/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    late bool isProvider;

    void selectUser(bool user) {
      isProvider = user;
    }

    return ChangeNotifierProvider(
      create: (context) => UserList(),
      child: MaterialApp(
        title: 'Meu Casório Club',
        theme: ThemeData(
            fontFamily: 'Lato',
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
        home: SplashScreen(),
        routes: {
          Routes.WELCOME_SCREEN: (context) => WelcomeScreen(),
          Routes.SELECT_USER: (context) => SelectUser(onSelected: selectUser),
          Routes.LOGIN: (context) => Login(
                isProvider: isProvider,
              ),
          Routes.FORGOT_PASSWORD: (context) => ForgotPassword(
                isProvider: isProvider,
              ),
          Routes.REGISTER: (context) => Register(isProvider: isProvider),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
