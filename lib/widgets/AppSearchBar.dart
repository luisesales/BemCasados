import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquise por produtos, serviços e fornecedores',
                  hintStyle: TextStyle(fontSize: 12),
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 213, 29, 72),
                shape: BoxShape.circle,
              ),
              height: 30,
              width: 30,
              child: Center(
                // Garante centralização
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20, // Tamanho do ícone
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
