import 'dart:io';
import 'dart:math';

import 'package:BemCasados/model/product_location.dart';
import 'package:BemCasados/services/product_services.dart';
import 'package:BemCasados/model/product.dart';
import 'package:BemCasados/utils/db_util.dart';

import 'package:flutter/material.dart';

class ProductsModel with ChangeNotifier {
  List<Product> _items = [];
  final ProductService _productService = ProductService();

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Product itemByIndex(int index) {
    return _items[index];
  }

  // parâmetro de localização adicionado
  void addProduct(String title, double price, String phone, String email,
      File img, ProductLocation location) async {
    final newProduct = Product(
        id: Random().nextDouble().toString(),
        title: title,
        price: price,
        phone: phone,
        email: email,
        location: location,
        image: img);

    _items.add(newProduct);

    DbUtil.insert('places', {
      'id': newProduct.id,
      'title': newProduct.title,
      'price': newProduct.price,
      'phone': newProduct.phone,
      'email': newProduct.email,
      'image': newProduct.image.path,
      'latitude': newProduct.location!.latitude, // pq n newProduct.loca...
      'longitude': newProduct.location!.longitude,
      'address': newProduct.location!.address,
    });

    await _productService.addProduct(
      id: newProduct.id,
      title: newProduct.title,
      price: newProduct.price,
      phone: newProduct.phone,
      email: newProduct.email,
      address: newProduct.location!.address ?? '',
      latitude: newProduct.location!.latitude,
      longitude: newProduct.location!.longitude,
      imageUrl: img.path, // Adapte se precisar de outra lógica para URLs
    );

    notifyListeners();
  }

  void removeProduct(String id) async {
    await DbUtil.delete('products', id);

    // Remove do Firebase
    await _productService.removeProduct(id);

    //remove da lista local
    _items.removeWhere((product) => product.id == id);
  }

  Future<void> loadProducts() async {
    final dataList = await DbUtil.getData('products');
    _items = dataList
        .map(
          (item) => Product(
            id: item['id'],
            title: item['title'],
            price: item['price'],
            phone: item['phone'],
            email: item['email'],
            image: File(item['image']),
            location: ProductLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
