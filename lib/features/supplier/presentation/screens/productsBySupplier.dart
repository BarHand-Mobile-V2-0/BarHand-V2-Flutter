
///nuevo codigo

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


    return Scaffold(
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
  late TextEditingController searchController;
  late TextEditingController descriptionController;
  late Product newProduct;

  @override
  void initState() {
    super.initState();
    products = productService.getProductsBySupplier(widget.supplierId);
    searchController = TextEditingController();
    descriptionController = TextEditingController();
    newProduct = Product(
      id: 0,
      name: '',
      category: '',
      image: '',
      price: 0,
      description: '',
      numberOfSales: 0,
      available: true,
      supplierId: widget.supplierId,
      rating: 0,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void addProduct() async {
    await productService.postProduct(newProduct);
    setState(() {
      products = productService.getProductsBySupplier(widget.supplierId);
    });
  }

  void deleteProduct(int id) async{
    await productService.deleteProduct(id);
    setState(() {
      products = productService.getProductsBySupplier(widget.supplierId);
    });
  }

  void editProduct(Product product) {
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
                    controller: searchController,
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
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: 'ProductName'),
                                    onChanged: (value) {
                                      setState(() {
                                        newProduct.name = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: 'Category'),
                                    onChanged: (value) {
                                      setState(() {
                                        newProduct.category = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: 'URL Image'),
                                    onChanged: (value) {
                                      setState(() {
                                        newProduct.image = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: 'Description'),
                                    onChanged: (value) {
                                      setState(() {
                                        newProduct.description = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: 'Price'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        newProduct.price = int.parse(value);
                                      });
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    addProduct();
                                    Navigator.of(context).pop(); // Cerrar la ventana flotante
                                  },
                                  child: const Text('Agregar'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> productList = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    Product product = productList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        deleteProduct(product.id);
                      },
                      child: Padding(
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
                                            const Icon(Icons.money_sharp),
                                            Text(
                                              ' S/ ${product.price.toStringAsFixed(2)}',
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
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Edit Product',
                                                    style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  const Text('Name'),
                                                  TextFormField(
                                                    initialValue: product.name,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.name = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  const Text('Category'),
                                                  TextFormField(
                                                    initialValue: product.category,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.category = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  const Text('Description'),
                                                  TextFormField(
                                                    initialValue: product.description,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.description = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  const Text('Image URL'),
                                                  TextFormField(
                                                    initialValue: product.image,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.image = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 16.0),

                                                  const Text('Price'),
                                                  TextFormField(
                                                    initialValue: product.price.toString(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.price = int.parse(value);
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      editProduct(product);
                                                      // Lógica para guardar los cambios realizados en el producto
                                                      // ...
                                                      Navigator.of(context).pop(); // Cerrar la ventana flotante
                                                    },
                                                    child: const Text('Save'),
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

  void searchProduct(String query) {
    setState(() {
      products = productService.getProductsBySupplier(widget.supplierId).then((productList) {
        return productList
            .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }
}



