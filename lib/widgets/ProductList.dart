import 'package:BemCasados/pages/products_detail_screen.dart';
import 'package:BemCasados/provider/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<ProductsModel>(context, listen: false).loadProducts(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<ProductsModel>(
                child: Center(
                  child: Text('Nenhum produto anunciado'),
                ),
                builder: (context, products, child) => products.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: products.itemsCount,
                        itemBuilder: (context, index) {
                          final product = products.itemByIndex(index);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(product.image),
                            ),
                            title: Text(product.title),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_forward,
                                  color: Colors.blueAccent),
                              onPressed: () {},
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ProductDetailScreen(
                                    title: product.title,
                                    price: product.price,
                                    description: product.description,
                                    phone: product.phone,
                                    email: product.email,
                                    image: product.image,
                                    address: product.location?.address ?? '',
                                    latitude: product.location?.latitude ?? 0.0,
                                    longitude:
                                        product.location?.longitude ?? 0.0,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
