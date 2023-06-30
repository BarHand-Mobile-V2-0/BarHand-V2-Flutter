import 'package:flutter/material.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';

class ProductsBySupplier extends StatelessWidget {
  final int supplierId;

  const ProductsBySupplier({Key? key, required this.supplierId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Supplier'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ProductsBySupplierView(supplierId: supplierId),
    );
  }
}

class _ProductsBySupplierView extends StatefulWidget {
  final int supplierId;

  const _ProductsBySupplierView({Key? key, required this.supplierId})
      : super(key: key);

  @override
  _ProductsBySupplierViewState createState() => _ProductsBySupplierViewState();
}

class _ProductsBySupplierViewState extends State<_ProductsBySupplierView> {
  late Future<List<Product>> products;
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    products = productService.getAllProduct();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void addProduct() {
    /*String name = nameController.text;
    String description = descriptionController.text;

    setState(() {
      // Crear el nuevo producto y agregarlo a la lista de productos
      Product newProduct = Product(
        name: name,
        description: description,
      );
      products.add(newProduct);
    });

    // Limpiar los controladores de texto
    nameController.clear();
    descriptionController.clear();*/
  }

  void deleteProduct(int index) {
    /*setState(() {
      products.removeAt(index);
    });*/
  }

  void editProduct( Product product) {
   productService.updateProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addProduct();
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
          FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> productList = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    Product product = productList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: AspectRatio(
                                  aspectRatio: 0.5,
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: IntrinsicHeight(
                                child: ListTile(
                                  title: Text(product.name),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Category: ${product.category}'),
                                      Row(
                                        children: [
                                          Icon(Icons.money_sharp),
                                          Text(
                                            ' \$${product.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Edit Product',
                                                  style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 16.0),
                                                Text('Name'),
                                                TextFormField(
                                                  initialValue: product.name,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product.name = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16.0),
                                                Text('Category'),
                                                TextFormField(
                                                  initialValue: product.category,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product.category = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16.0),
                                                Text('Description'),
                                                TextFormField(
                                                  initialValue: product.description,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product.description = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16.0),
                                                Text('Image URL'),
                                                TextFormField(
                                                  initialValue: product.image,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product.image = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16.0),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    editProduct(product);
                                                    // Lógica para guardar los cambios realizados en el producto
                                                    // ...
                                                    Navigator.of(context).pop(); // Cerrar la ventana flotante
                                                  },
                                                  child: Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
