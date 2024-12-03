import 'package:flutter/material.dart';
import 'package:nuptia/components/AppSearchBar.dart';
import 'package:nuptia/components/CircleCartIcon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), // Altura total ajustada
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 213, 29, 72),
          elevation: 4.0,
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'UM MAIS UM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleCartIcon(),
                    ],
                  ),
                ),
                SizedBox(height: 8), // Espaço entre as linhas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppSearchBar(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seção principal',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Widget exemplo 1
                    Card(
                      elevation: 2.0,
                      child: ListTile(
                        leading: Icon(Icons.info),
                        title: Text('Informação 1'),
                        subtitle: Text('Detalhes importantes aqui'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    // Widget exemplo 2
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Ação principal'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
