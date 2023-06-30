import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';

import '../../shared/widgets/side_menu.dart';

class ProductScreen1 extends StatelessWidget {
  final Product product;

  const ProductScreen1({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body:SingleChildScrollView(
      child:
      Container(
        child: FutureBuilder<Product>(
          future: productService.getProductById(product.id),
          builder: (context, AsyncSnapshot<Product> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final productData = snapshot.data!;
              return Center(
                child: Card(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(20),
                          height: 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              productData.image,
                              fit: BoxFit.contain,
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productData.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          productData.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' \$ ${productData.price.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () => context.push(
                                '/store/supplier/${productData.supplierId}'),
                            child: Text('Supplier'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            child: Text('Detalles'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),

      )
    );
  }
}
