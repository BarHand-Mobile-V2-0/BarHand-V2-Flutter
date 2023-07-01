import 'package:flutter/material.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';
import 'package:ur_provider/features/supplier/domain/entities/supplier.dart';
import 'package:ur_provider/features/supplier/domain/service/supplier_service.dart';
import 'package:ur_provider/features/supplier/presentation/screens/editProfileSupplier.dart';
import 'package:ur_provider/features/supplier/presentation/screens/productsBySupplier.dart';
import 'package:ur_provider/features/supplier/presentation/screens/supplierClients.dart';

class SupplierProfile extends StatelessWidget {
  final int supplierId;

  const SupplierProfile({Key? key, required this.supplierId}) : super(key: key);

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
      body: _SupplierProfileView(supplierId: supplierId),
    );
  }
}

class _SupplierProfileView extends StatefulWidget {
  final int supplierId;

  const _SupplierProfileView({Key? key, required this.supplierId})
      : super(key: key);

  @override
  _SupplierProfileViewState createState() => _SupplierProfileViewState();
}

class _SupplierProfileViewState extends State<_SupplierProfileView> {
  late Future<List<Product>> products;
  late Supplier supplier;

  @override
  void initState() {
    super.initState();
    products = productService.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<Supplier>(
                future: SupplierService.getSupplierById(widget.supplierId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data;
                    supplier = data!;

                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 200,
                                  backgroundImage: NetworkImage(
                                    snapshot.data?.image ?? 'N/A',
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: FloatingActionButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileSupplier(
                                                supplier: supplier),
                                      ),
                                    ),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    "${snapshot.data!.description}",
                                    maxLines: null,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 8.0),
                                Text(
                                  snapshot.data!.email,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 8.0),
                                Text(
                                  snapshot.data?.address ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 8.0),
                                Text(
                                  "${snapshot.data!.name} ${snapshot.data!.lastName}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.category),
                                SizedBox(width: 8.0),
                                Text(
                                  "${snapshot.data!.category}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8.0),
                                Text(
                                  snapshot.data?.phone.toString() ?? 'S/N',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.document_scanner),
                                SizedBox(width: 8.0),
                                Text(
                                  snapshot.data?.ruc.toString() ?? 'S/N',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          BottomNavigationBar(
            backgroundColor: Colors.blueGrey[700],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Productos',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Clientes',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsBySupplier(
                        supplierId: widget.supplierId,
                      ),
                    ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupplierClients(
                      supplierId: widget.supplierId,
                    ),
                  ),
                );

                // Acción del botón de Clientes
              }
            },
          ),
        ],
      ),
    );
  }
}



/*
*   Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //A
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  "${snapshot.data!.description}",
                                  maxLines: null,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data!.email,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data?.address ?? 'N/A',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 8.0),
                              Text(
                                "${snapshot.data!.name} ${snapshot.data!.lastName}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.category),
                              SizedBox(width: 8.0),
                              Text(
                                "${snapshot.data!.category}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data?.phone.toString() ?? 'S/N',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.document_scanner),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data?.ruc.toString() ?? 'S/N',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //B
* */

/* ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>
                        SearchProduct()
                )
            ),
            child: const Text('Buscar Productos'),
          ),*/


/* Expanded(
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final productList = snapshot.data ?? [];
                  return CarouselSlider.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index, realIndex) {
                      final product = productList[index];
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(product.name),
                            Image.network(
                              product.image.toString(),
                              fit: BoxFit.cover,
                              height: 190,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Ver Producto'),
                                  onPressed: () =>Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductScreen1(product: product),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('añadir'),
                                  onPressed: () {
                                    /* ... */
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }
              },
            ),
          ),*/
