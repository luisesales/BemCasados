import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuptia/utils/routes.dart';

class SelectUser extends StatelessWidget {
  final Function(bool) onSelected;
  const SelectUser({super.key, required this.onSelected});

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
                  flex: 1, child: SvgPicture.asset("assets/images/logo.svg")),
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/casal_na_moto.png',
                  height: 220, // Aumentei o tamanho da imagem
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double
                            .infinity, // Isso faz o botão ocupar a linha inteira
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onSelected(false);
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            child: Text(
                              'Quero organizar meu casamento',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      SizedBox(
                        width: double
                            .infinity, // Isso faz o botão ocupar a linha inteira
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onSelected(true);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            child: Text(
                              'Quero anunciar meus serviços',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
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
