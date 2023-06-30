
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/inventory/presentation/product_card_by_store.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  late Future<List<Product>> allProducts;
  List<Product> displayedProducts = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    allProducts = productService.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bucar Producto'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: searchProduct,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: allProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final productList = snapshot.data ?? [];
                  displayedProducts = productList;
                  if (controller.text.isNotEmpty) {
                    displayedProducts = displayedProducts.where((product) {
                      final productName = product.name.toLowerCase();
                      final input = controller.text.toLowerCase();
                      return productName.contains(input);
                    }).toList();
                  }
                  return ListView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return ListTile(
                        leading: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(product.name),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen1(product: product),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchProduct(String query) {
    setState(() {});
  }
}
