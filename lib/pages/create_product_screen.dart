import 'dart:io';

import 'package:BemCasados/model/product_location.dart';
import 'package:BemCasados/provider/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  File? _pickedImage;
  ProductLocation? _currLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveLocation(ProductLocation currLocation) {
    _currLocation = currLocation;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _pickedImage == null ||
        _currLocation == null) {
      print('Por favor, preencha todos os campos.'); //transformar em snackbar
      return;
    }

    final price = double.tryParse(_priceController.text);
    if (price == null || price <= 0) {
      print('Por favor, insira um preço válido.');
      return;
    }

    if (_titleController.text.isEmpty) {
      print('O título não pode estar vazio.');
      return;
    }

    if (_pickedImage == null) {
      print('Por favor, selecione uma imagem.');
      return;
    }

    if (_currLocation == null) {
      print('Por favor, selecione uma localização.');
      return;
    }

    Provider.of<ProductsModel>(context, listen: false).addProduct(
        _titleController.text,
        _descriptionController.text,
        price,
        _phoneController.text,
        _emailController.text,
        _pickedImage!,
        _currLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anunciar produto', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 213, 29, 72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crie um novo anúncio de produto ou serviço!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),

            // TÍTULO
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título do anúncio',
                prefixIcon: Icon(Icons.title, color: Colors.blue.shade900),
              ),
            ),

            // IMAGEM DO PRODUTO
            /* SizedBox(height: 10),
            ImageInput(this._selectImage), */

            // DESCRIÇÃO
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição (até 300 caracteres)',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.blue.shade900,
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            // INFORMAÇÕES PESSOAIS E VALOR
            // INLINE DE TELEFONE COM PREÇO À DIREITA
            //EMAIL
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue.shade900,
                ),
              ),
              maxLines: 4,
            ),

            //PREÇO
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'R\$',
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: Colors.blue.shade900,
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            // TELEFONE PRA CONTATO
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: '(DDD) 90000-0000',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.blue.shade900,
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para criar o anúncio
              },
              child: Text('Criar Anúncio'),
            ),
          ],
        ),
      ),
    );
  }
}
