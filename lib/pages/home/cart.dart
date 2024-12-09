import 'package:nuptia/model/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key}); //por que?

  @override
  Widget build(BuildContext context) {
    final productList =
        Provider.of<ProductList>(context); // obtém o estado do carrinho

    return Scaffold(
      appBar: AppBar(
          title: const Text('Carrinho'),
          backgroundColor: Theme.of(context).primaryColor),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${productList.total.toStringAsFixed(2)}', // mostra o total formatado
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Lista de itens no carrinho
          Expanded(
            child: ListView.builder(
              itemCount: productList
                  .items.length, // Substitua pelo número de itens no carrinho
              itemBuilder: (ctx, index) {
                final product = productList.items[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.title),
                  subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      productList.removeProduct(product);
                    },
                  ),
                );
              },
            ),
          ),
          // Botão de finalizar compra
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Orçamento Pago!')),
                  );
                },
                child: const Text(
                  'Finalizar Orçamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
