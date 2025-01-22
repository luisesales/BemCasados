import 'dart:io';
import 'package:flutter/material.dart';
import 'package:BemCasados/model/product_location.dart';

class Product with ChangeNotifier {
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
