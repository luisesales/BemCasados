import 'package:flutter/material.dart';
import 'package:nuptia/widgets/AppSearchBar.dart';
import 'package:nuptia/widgets/CircleCartIcon.dart';
import 'package:nuptia/widgets/CustomAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
