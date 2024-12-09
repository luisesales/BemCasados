import 'package:flutter/material.dart';
import 'package:nuptia/model/cartItem.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem; // O item do carrinho
  final VoidCallback onRemove; // Callback para remover o item
  final VoidCallback onIncrement; // Callback para aumentar a quantidade
  final VoidCallback onDecrement; // Callback para diminuir a quantidade

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do Produto
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cartItem.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do Produto
                Text(
                  cartItem.product.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Preço do Produto
                Text(
                  'R\$ ${cartItem.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                // Subtotal do Item
                Text(
                  'Subtotal: R\$ ${cartItem.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Botões de Controle de Quantidade
          Column(
            children: [
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add, color: Colors.green),
              ),
              Text(
                '${cartItem.quantity}',
                style: const TextStyle(fontSize: 16.0),
              ),
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove, color: Colors.red),
              ),
            ],
          ),
          // Botão de Remover
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
