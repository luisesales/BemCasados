import 'package:flutter/material.dart';
import 'package:nuptia/widgets/AppSearchBar.dart';
import 'package:nuptia/widgets/CircleCartIcon.dart';
import 'package:nuptia/widgets/CustomAppBar.dart';
import 'package:nuptia/widgets/WeddingCountdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            const Text(
              'Bem-vinda, Alice',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const Text(
              'Continue os preparativos para o seu casamento',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16.0),
            WeddingCountdown(
              imageUrl: 'assets/images/0008-danibruno_pw-1000x668.png',
              title: 'Alice & Marcos',
              onExpand: () {
                // Lógica para expandir o card
              },
              onMenuTap: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Seção da imagem de fundo
                    const SizedBox(height: 12.0),
                    // Botão de ação principal
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ação principal'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
