import 'package:flutter/material.dart';

class MyWeddingActions extends StatelessWidget {
  final String buttonLabel;
  final Icon icon; // Agora você passa o widget Icon diretamente
  final VoidCallback onTap;

  const MyWeddingActions({
    super.key,
    required this.buttonLabel,
    required this.icon, // Recebendo o ícone diretamente
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Faz o tamanho da coluna ser ajustado pelo conteúdo
          children: [
            icon, // Aqui o ícone é passado diretamente
            SizedBox(height: 4), // Espaço entre o ícone e o texto
            Text(
              buttonLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 65, 65, 65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
