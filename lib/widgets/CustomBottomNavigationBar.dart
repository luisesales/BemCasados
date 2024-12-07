import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(
            key:
                key); // o parâmetro key (não sei para que serve) é passado para o construtor do super

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
            icon: Icon(Icons.ring_volume), label: 'Notificações'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Marketplace'),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard), label: 'Presentes'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuário'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color.fromRGBO(213, 29, 72, 100),
      onTap: onItemTapped,
    );
  }
}
