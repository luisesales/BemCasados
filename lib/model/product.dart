class Product {
  final String name; // Nome do produto
  final double price; // Preço do produto
  final String imageUrl; // URL ou caminho da imagem associada ao produto

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
=======
import 'dart:io';
import 'package:BemCasados/model/product_location.dart';

class Product {
  final String id;
  final double price;
  final String title;
  final String description;
  final ProductLocation? location;
  final File image;
  final String phone;
  final String email;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    this.location,
    required this.image,
    required this.phone,
    required this.email,
  });
}
