import 'package:flutter/material.dart';
import 'package:nuptia/utils/appRoutes.dart';
import 'package:nuptia/pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a bandeira de debug
      title: 'Bem Casados',
      initialRoute: AppRoutes.USER_HOME,
      routes: {
        AppRoutes.USER_HOME: (ctx) => const HomeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink, // Define o tema principal
      ),
    );
  }
}
