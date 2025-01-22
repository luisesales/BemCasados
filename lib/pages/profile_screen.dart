import 'dart:io';
import 'package:BemCasados/model/userList.dart';
import 'package:BemCasados/pages/products_detail_screen.dart';
import 'package:BemCasados/provider/products_model.dart';
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
    File? _userImage; // Implementar foto do usuário depois

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade900,
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
            SizedBox(height: 20),
            isProvider
                ? Expanded(
                    child: FutureBuilder(
                      future: Provider.of<ProductsModel>(context, listen: false)
                          .loadProducts(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Consumer<ProductsModel>(
                          child: Center(
                            child: Text(
                              'Nenhum produto adicionado.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          builder: (context, products, child) {
                            if (products.itemsCount == 0) return child!;
                            return ListView.builder(
                              itemCount: products.itemsCount,
                              itemBuilder: (context, index) {
                                final product = products.itemByIndex(index);
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(product.image),
                                  ),
                                  title: Text(product.title),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('Confirmação'),
                                          content: Text(
                                            'Deseja realmente remover este produto?',
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('Cancelar'),
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(false),
                                            ),
                                            ElevatedButton(
                                              child: Text('Remover'),
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(true),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        Provider.of<ProductsModel>(context,
                                                listen: false)
                                            .removeProduct(product.id);
                                      }
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => ProductDetailScreen(
                                          title: product.title,
                                          description: product.description,
                                          price: product.price,
                                          image: product.image,
                                          phone: product.phone,
                                          email: product.email,
                                          address: product.location!.address,
                                          latitude: product.location!.latitude,
                                          longitude:
                                              product.location!.longitude,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                : Text('Em breve: Informações sobre seu casamento'),
          ],
        ),
      ),
    );
  }
}
