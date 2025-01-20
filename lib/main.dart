import 'package:BemCasados/pages/gifts_list_page.dart';
import 'package:BemCasados/pages/notifications_screen.dart';
import 'package:BemCasados/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:BemCasados/pages/auth/login.dart';
import 'package:BemCasados/pages/auth/selectUser.dart';
import 'package:BemCasados/pages/auth/register.dart';
import 'package:BemCasados/pages/auth/forgotPassword.dart';
import 'package:BemCasados/pages/auth/splashScreen.dart';
import 'package:BemCasados/pages/auth/welcomeScreen.dart'; // Certifique-se de ter a tela de bem-vindo
import 'package:BemCasados/pages/create_product_screen.dart'; // Certifique-se de ter a tela de bem-vindo

import 'package:BemCasados/model/userList.dart';
import 'package:BemCasados/pages/home/home.dart';
import 'package:BemCasados/pages/marketplace/marketplace.dart'; // Importando a página do marketplace
import 'package:provider/provider.dart';
import 'package:BemCasados/utils/routes.dart';

final String API_KEY = 'AIzaSyBdq5B1nT885EM68SgPuPANNzKd6nnsNc4';

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
        title: 'Bem Casados',
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
        home: SplashScreen(),
        routes: {
          Routes.WELCOME_SCREEN: (context) =>
              WelcomeScreen(), // Tela de Bem-Vindo
          Routes.SELECT_USER: (context) => SelectUser(onSelected: selectUser),
          Routes.LOGIN: (context) => Login(isProvider: isProvider),
          Routes.FORGOT_PASSWORD: (context) =>
              ForgotPassword(isProvider: isProvider),
          Routes.REGISTER: (context) => Register(isProvider: isProvider),
          Routes.PRODUCT_FORM: (context) => CreateProductScreen(),

          Routes.HOME_SCREEN: (context) => HomeScreen(),
          Routes.NOTIFICATIONS_SCREEN: (context) => NotificationsScreen(),
          Routes.MARKETPLACE_SCREEN: (context) =>
              MarketplacePage(), // Rota para MarketplacePage
          Routes.GIFTS_LIST_SCREEN: (context) => GiftsListScreen(),
          Routes.PROFILE_SCREEN: (context) => ProfileScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
