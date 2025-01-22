import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
      ),
      body: ListView.builder(
        itemCount: 10, // Simulando 10 notificações
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.black),
            title: Text('Notificação ${index + 1}'),
            subtitle: Text('Aqui vai o conteúdo da notificação'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Lógica ao clicar na notificação
            },
          );
        },
      ),
    );
  }
}
