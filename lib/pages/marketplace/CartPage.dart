import 'package:flutter/material.dart';
import 'package:nuptia/model/cartItem.dart';
import 'package:nuptia/widgets/cartItemWidget.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems; 

  const CartPage({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Função para incrementar a quantidade de um item
  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  // Função para decrementar a quantidade de um item
  void _decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) item.quantity--;
    });
  }

  // Função para remover um item do carrinho
  void _removeItem(CartItem item) {
    setState(() {
      widget.cartItems.remove(item);
    });
  }

  // Calcula o preço total do carrinho
  double get totalPrice =>
      widget.cartItems.fold(0, (total, item) => total + item.subtotal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                "Seu carrinho está vazio.",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return CartItemWidget(
                        cartItem: item,
                        onIncrement: () => _incrementQuantity(item),
                        onDecrement: () => _decrementQuantity(item),
                        onRemove: () => _removeItem(item),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: R\$ ${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Ação ao finalizar a compra
                        },
                        child: const Text("Finalizar Compra"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
