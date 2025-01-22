import 'package:flutter/material.dart';

class CircleCartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      width: 30,
      height: 30,
      child: Icon(
        Icons.shopping_cart_rounded,
        color: const Color.fromARGB(255, 117, 117, 117),
        size: 20,
      ),
    );
  }
}
