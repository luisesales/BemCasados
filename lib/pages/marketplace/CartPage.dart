import 'package:flutter/material.dart';
import 'package:nuptia/model/CartItem.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.cartItems.fold(
        0.0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
        backgroundColor: Colors.pink,
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text("Seu carrinho está vazio!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Card(
                        margin:
                            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text("R\$ ${item.price.toStringAsFixed(2)} x ${item.quantity}"),
                          trailing: Text("R\$ ${item.total.toStringAsFixed(2)}"),
                          leading: IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                widget.cartItems.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Total: R\$ ${totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                      onPressed: () {
                          // Placeholder para finalizar a compra
                        },
                      child: const Text(
                          "Finalizar Compra",
                          style: TextStyle(
                          color: Colors.white, // Define a cor do texto como branco
                          ),
                      ),
                    ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
