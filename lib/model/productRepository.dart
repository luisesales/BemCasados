/* import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:BemCasados/model/product_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:BemCasados/model/product.dart';
import 'package:flutter/cupertino.dart';

class ProductRepository with ChangeNotifier {
  final _baseUrl = 'https://bemcasados-a6b2b-default-rtdb.firebaseio.com/';
  List<Product> _productList = [];
  Product? _currentProduct;

  List<Product> get products {
    return [..._productList];
  }

/*   Future<List<Product>> fetchProducts() async {
    List<Product> products = [];
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products.json'));
      if (response.statusCode == 200) {
        Map<String, dynamic> _productListJson = jsonDecode(response.body);
        _productListJson.forEach((id, product) {
          products.add(Product.fromJson(id, product));
        });
        _productList = products;
        return products;
      } else {
        throw Exception('Aconteceu algum erro na requisição');
      }
    } catch (e) {
      throw e;
    }
  } */

  /* Future<void> addProduct(Product product) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/products.json'),
          body: jsonEncode(product.toJson()));
      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['title'];
        _productList.add(Product(
            id: id,
            price: product.price,
            title: product.title,
            description: product.description,
            phone: product.phone,
            email: product.email,
            image: product.image,
            location: product.location));
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  } */

  /*  Future<void> updateProduct(Product product) async {
    try {
      var response = await http.put(
          Uri.parse('$_baseUrl/products/${product.id}.json'),
          body: jsonEncode(product.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['title'];
        Product newProduct = Product(
            id: id,
            price: product.price,
            title: product.title,
            description: product.description,
            phone: product.phone,
            email: product.email,
            image: product.image,
            location: product.location);
        _productList.remove(product);
        _productList.add(newProduct);
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  } */

  /* Future<void> saveProduct(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final product = Product(
        id: hasId
            ? (data['id'] as String?) ?? Random().nextDouble().toString()
            : Random().nextDouble().toString(),
        price: (data['price'] as num).toDouble(),
        title: (data['title'] as String?) ?? 'New title',
        description: (data['description'] as String?) ?? 'New description',
        location: data['location'] != null &&
                data['location'] is Map<String, dynamic>
            ? ProductLocation(
                latitude: (data['location']['latitude'] as double?) ?? 0.0,
                longitude: (data['location']['longitude'] as double?) ?? 0.0,
                address: (data['location']['address'] as String?) ?? 'Endereço',
              )
            : null,
        image: data['image'] != null && data['image'] is String
            ? File(data['image'] as String)
            : File(
                'path/to/default_image.png'), // caminho padrão para evitar erro

        phone: (data['phone'] as String?) ?? 'New phone',
        email: (data['email'] as String?) ?? 'New email'); */

    /* if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    } */
  }
}
 */
