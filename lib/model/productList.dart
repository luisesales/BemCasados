import 'dart:convert';
import 'dart:math';

import 'package:BemCasados/model/user.dart';
import 'package:BemCasados/model/product.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://bemcasados-a6b2b-default-rtdb.firebaseio.com/';

  bool _showFavoriteOnly = false;

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  double get total {
    if (_items.isEmpty) return 0.0;
    return _items.map((product) => product.price).reduce((a, b) => a + b);
  }

  List<Product> favoriteItems(User user) {
    return [..._items.where((prod) => user.favorites.contains(prod))];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];

    try {
      final response = await http.get(Uri.parse('$_baseUrl/products.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> _productsJson = jsonDecode(response.body);

        _productsJson.forEach((id, product) {
          products.add(Product.fromJson(id, product));
        });
        _items = products;
        return products;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/products.json'),
          body: jsonEncode(product.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        _items.add(Product(
            id: id,
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl));
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
    // print('executa em sequencia');
  }

  Future<void> updateProduct(Product product) async {
    try {
      var response = await http.put(
          Uri.parse('$_baseUrl/products/${product.id}.json'),
          body: jsonEncode(product.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        Product newProduct = Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );
        _items.remove(product);
        _items.add(newProduct);
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  bool objectToBool(Object? obj) {
    if (obj == null) return false;
    if (obj is bool) return obj;
    if (obj is String) return obj.isNotEmpty;
    if (obj is int) return obj > 0;
    return false;
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId
          ? (data['id'] as String?) ?? Random().nextDouble().toString()
          : Random().nextDouble().toString(),
      title: (data['title'] as String?) ?? 'Título Padrão',
      description: (data['description'] as String?) ?? 'Descrição Padrão',
      price: (data['price'] as double?) ?? 0.0,
      imageUrl: (data['imageUrl'] as String?) ?? '',
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> removeProduct(Product product) async {
    try {
      final response =
          await http.delete(Uri.parse('$_baseUrl/products/${product.id}.json'));

      if (response.statusCode == 200) {
        removeProductFromList(product);
      } else {
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  void removeProductFromList(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
