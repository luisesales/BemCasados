import 'dart:io';
import 'dart:math';

import 'package:BemCasados/model/product_location.dart';
import 'package:BemCasados/model/product.dart';
import 'package:BemCasados/utils/db_util.dart';

import 'package:flutter/material.dart';

class ProductsModel with ChangeNotifier {
  List<Product> _items = [];

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
  Future<void> addProduct(String title, String description, double price,
      String phone, String email, File img, ProductLocation location) async {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: title,
      description: description,
      price: price,
      phone: phone,
      email: email,
      location: location,
      image: img,
    );

    _items.add(newProduct);

    await DbUtil.insert('products', {
      'id': newProduct.id,
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'phone': newProduct.phone,
      'email': newProduct.email,
      'image': newProduct.image.path,
      'latitude': newProduct.location!.latitude,
      'longitude': newProduct.location!.longitude,
      'address': newProduct.location!.address,
    });

    notifyListeners();
  }

  void removeProduct(String id) async {
    await DbUtil.delete('products', id);

    /* // Remove do Firebase
    await _productService.removeProduct(id); */

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
            description: item['description'],
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
