import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white), label: 'Início'),
        BottomNavigationBarItem(
            icon: Icon(Icons.ring_volume, color: Colors.white),
            label: 'Notificações'),
        BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.white), label: 'Marketplace'),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: Colors.white),
            label: 'Presentes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white), label: 'Usuário'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white, // cor do ícone selecionado
      unselectedItemColor: Colors.white, // cor dos ícones não selecionados
      onTap: onItemTapped,
      backgroundColor:
          Color.fromRGBO(213, 29, 72, 100), // Define a cor de fundo da barra
    );
  }
}
