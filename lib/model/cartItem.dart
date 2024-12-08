class CartItem {
  final String title;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;
}
