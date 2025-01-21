import 'package:flutter/material.dart';

class IntroSecondStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFFFDDDD), // Atualizei a cor de fundo para #FFDDDD
      body: Center(
        heightFactor: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Adicione a imagem do casal na moto aqui
                Image.asset(
                  'assets/images/casal_se_abracando.png',
                  height: 220, // Aumentei o tamanho da imagem
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Mais do que um',
                      style: TextStyle(
                        fontSize: 22, // Diminuí o tamanho da fonte
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Marketplace',
                      style: TextStyle(
                        fontSize: 22, // Diminuí o tamanho da fonte
                        fontWeight: FontWeight.w800,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Descubra uma variedade de opções personalizadas e dicas inspiradoras para tornar seu casamento único e inesquecível.',
                  style: TextStyle(
                    fontSize: 14, // Diminuí o tamanho da fonte
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/intro-third-step');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).primaryColor, // Cor do botão
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Continuar',
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
        ),
      ),
    );
  }
}
