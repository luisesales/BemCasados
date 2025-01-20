import 'dart:io';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'John Doe';
  bool isProvider = true; // Altere conforme necessário
  File? _userImage;

  void _pickImage() async {
    // Lógica para pegar a imagem (pode ser via ImagePicker ou outra ferramenta)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
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
                backgroundImage: _userImage != null
                    ? FileImage(_userImage!)
                    : AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
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
              'Nome: $userName',
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
          ],
        ),
      ),
    );
  }
}
