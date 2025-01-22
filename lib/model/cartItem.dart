import 'package:nuptia/model/product.dart'; 

class CartItem {
  final Product product; 
  int quantity; 

  CartItem({
    required this.product,
    this.quantity = 0, //quantidade inicial padrão
  });

  double get subtotal => product.price * quantity;
}