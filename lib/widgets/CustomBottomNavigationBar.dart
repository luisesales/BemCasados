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
      backgroundColor: Colors.pink, // Define a cor de fundo da barra
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), label: 'Início'),
        BottomNavigationBarItem(
            icon: Icon(Icons.ring_volume, color: Colors.black),
            label: 'Notificações'),
        BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.black), label: 'Marketplace'),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: Colors.black),
            label: 'Presentes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black), label: 'Usuário'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white, // cor do ícone selecionado
      unselectedItemColor: Colors.white, // cor dos ícones não selecionados
      onTap: onItemTapped,
    );
  }
}
