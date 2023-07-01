import 'package:flutter/material.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';

class StoreViewProduct extends StatelessWidget {
  final int supplierId;

  const StoreViewProduct({Key? key, required this.supplierId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: _StoreViewProductView(supplierId: supplierId),
    );
  }
}

class _StoreViewProductView extends StatefulWidget {
  final int supplierId;

  const _StoreViewProductView({Key? key, required this.supplierId}) : super(key: key);

  @override
  _StoreViewProductViewState createState() => _StoreViewProductViewState();
}

class _StoreViewProductViewState extends State<_StoreViewProductView> {
  late Future<List<Product>> products;
  late TextEditingController searchController;
  late TextEditingController descriptionController;
  late Product newProduct;

  @override
  void initState() {
    super.initState();
    products = productService.getProductsBySupplier(widget.supplierId);
    searchController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error al cargar los productos');
          } else if (snapshot.hasData) {
            final productList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ProductCard(product: product);
              },
            );
          } else {
            return const Text('No se encontraron productos');
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\S/${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de agregar al carrito
                // Puedes implementar la lógica que desees aquí
              },
              child: const Text('Agregar al carrito'),
            ),
          ),
        ],
      ),
    );
  }
}


