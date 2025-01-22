import 'dart:io';
import 'dart:math';

import 'package:BemCasados/components/image_input.dart';
import 'package:BemCasados/components/location_input.dart';
import 'package:BemCasados/model/product.dart';
import 'package:BemCasados/model/productRepository.dart';
import 'package:BemCasados/model/product_location.dart';
import 'package:BemCasados/pages/home/home.dart';
import 'package:BemCasados/pages/home/home_content_screen.dart';
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

  void _submitForm() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _pickedImage == null ||
        _currLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
      return;
    }

    final price = double.tryParse(_priceController.text);
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um preço válido.'),
        ),
      );
      return;
    }

/*     // Criar o produto
    final product = Product(
      id: Random().nextDouble().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      price: price,
      phone: _phoneController.text,
      email: _emailController.text,
      image: _pickedImage!,
      location: ProductLocation(
        latitude: _currLocation!.latitude,
        longitude: _currLocation!.longitude,
        address: _currLocation!.address,
      ),
    ); */

    try {
      // Salvar localmente
      Provider.of<ProductsModel>(context, listen: false).addProduct(
        _titleController.text,
        _descriptionController.text,
        price,
        _phoneController.text,
        _emailController.text,
        _pickedImage!,
        ProductLocation(
          latitude: _currLocation!.latitude,
          longitude: _currLocation!.longitude,
          address: _currLocation!.address,
        ),
      );

      /* // Salvar remotamente
      await Provider.of<ProductRepository>(context, listen: false)
          .addProduct(product); */

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false, // Remove todas as rotas anteriores
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o produto: $error')),
      );
      print("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anunciar produto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 213, 29, 72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crie um novo anúncio de produto ou serviço!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título do anúncio',
                  prefixIcon: Icon(Icons.title, color: Colors.black),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Adicione uma foto ao seu anúncio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 4),
              ImageInput(_selectImage),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição (até 300 caracteres)',
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              const Text(
                'Localização',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 4),
              LocationInput(_saveLocation),
              const SizedBox(height: 20),
              const Text(
                'Informações gerais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: '(DDD) 90000-0000',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'R\$',
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Criar Anúncio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
