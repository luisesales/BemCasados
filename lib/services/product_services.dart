import 'package:firebase_database/firebase_database.dart';

class ProductService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref(); // Referência raiz

  Future<void> addProduct({
    required String id,
    required String title,
    required double price,
    required String phone,
    required String email,
    required String address,
    required double latitude,
    required double longitude,
    required String imageUrl,
  }) async {
    try {
      await _dbRef.child('products/$id').set({
        'title': title,
        'price': price,
        'phone': phone,
        'email': email,
        'address': address,
        'location': {
          'latitude': latitude,
          'longitude': longitude,
        },
        'imageUrl': imageUrl,
      });
    } catch (error) {
      print('Erro ao adicionar produto: $error');
      rethrow;
    }
  }

  Future<void> removeProduct(String id) async {
    await _dbRef
        .child('products/$id')
        .remove(); // Remove o nó correspondente ao ID
  }
}
