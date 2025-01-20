import 'package:flutter/material.dart';

class GiftsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Presentes'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.blue.shade900),
            title: Text('Presente 1'),
            subtitle: Text('Descrição do presente 1'),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.blue.shade900),
            title: Text('Presente 2'),
            subtitle: Text('Descrição do presente 2'),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.blue.shade900),
            title: Text('Presente 3'),
            subtitle: Text('Descrição do presente 3'),
          ),
          // Adicione mais itens conforme necessário
        ],
      ),
    );
  }
}
