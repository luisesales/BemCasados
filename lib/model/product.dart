import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Constructor that clones from an existing Product
  Product.fromProduct(Product _product)
      : id = _product.id,
        title = _product.title,
        description = _product.description,
        price = _product.price,
        imageUrl = _product.imageUrl;

  // Factory method to create a Product instance from a JSON map
  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      title: json['title'],
      description: json['description'],
      price: json['price']
          .toDouble(), // Assuming 'price' is stored as a double in JSON
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
    return data;
  }
}
