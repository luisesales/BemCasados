import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: ListView(
            children: [
              SvgPicture.asset("assets/images/logobc.svg", height: 100),
              Image.asset(
                'assets/images/casal_tomando_cafe.png',
                height: MediaQuery.of(context).size.height * 2 / 3,
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
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
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: () {
                          onSelected(true);
                          Navigator.of(context).pushNamed('/login');
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
            ],
          ),
        ),
      ),
    );
  }
}
