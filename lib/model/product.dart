import 'dart:io';
import 'package:BemCasados/model/product_location.dart';

class Product {
  final String id;
  final double price;
  final String title;
  final ProductLocation? location;
  final File image;
  final String phone;
  final String email;

  Product({
    required this.id,
    required this.price,
    required this.title,
    this.location,
    required this.image,
    required this.phone,
    required this.email,
  });
}
