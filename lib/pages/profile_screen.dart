import 'dart:io';
import 'package:BemCasados/model/userList.dart';
import 'package:BemCasados/widgets/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _pickImage() async {
    // Lógica para pegar a imagem (pode ser via ImagePicker ou outra ferramenta)
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<UserList>(context, listen: false).currentUser;
    final isProvider = currentUser?.isProvider ?? false;
    final userName = currentUser?.username;
    File? _userImage; //Implementar foto do usuário depois

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade900,
/*                 backgroundImage:  */
                child: _userImage == null
                    ? Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$userName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tipo de usuário: ${isProvider ? 'Fornecedor' : 'Usuário Comum'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para editar perfil
              },
              child: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            isProvider
                ? ProductList()
                : Text('Em breve: Informações sobre seu casamento'),
          ],
        ),
      ),
    );
  }
}
