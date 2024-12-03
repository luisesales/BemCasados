import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Casório Club',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFD51D48), // Atualizei a cor de fundo para #D51D48
      body: Center(
        child: Text(
          'MEU CASÓRIO CLUB\nDeixa com a gente!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, // Diminuí o tamanho da fonte
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFFFDDDD), // Atualizei a cor de fundo para #FFDDDD
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Adicione a imagem do casal na moto aqui
            Image.asset(
              'assets/images/casal_na_moto.png',
              height: 220, // Aumentei o tamanho da imagem
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo ao Bem Casados!',
              style: TextStyle(
                fontSize: 22, // Diminuí o tamanho da fonte
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Seu casamento começa aqui: conectamos você aos melhores fornecedores, dicas inspiradoras e ferramentas práticas para organizar cada detalhe do grande dia de forma simples, personalizada e encantadora.',
              style: TextStyle(
                fontSize: 14, // Diminuí o tamanho da fonte
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de introdução
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Cor do botão
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Vamos começar!',
                style: TextStyle(
                  fontSize: 16, // Diminuí o tamanho da fonte
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Removi os círculos
          ],
        ),
      ),
    );
  }
}
