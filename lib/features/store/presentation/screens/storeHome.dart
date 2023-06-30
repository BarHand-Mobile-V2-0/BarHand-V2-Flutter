import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/inventory/presentation/product_card_by_store.dart';

import 'package:ur_provider/features/store/domain/domain.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';
import 'package:ur_provider/features/shared/widgets/widgets.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';
import 'package:ur_provider/features/store/presentation/screens/searchProduct.dart';

var storeId;

class StoreHome extends StatelessWidget {
  final int storeId;

  const StoreHome({Key? key, required this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStoreId(storeId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Stores'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _StoreHomeView(),
    );
  }
}

class _StoreHomeView extends StatefulWidget {
  const _StoreHomeView();

  @override
  _StoreHomeViewState createState() => _StoreHomeViewState();
}

class _StoreHomeViewState extends State<_StoreHomeView> {
  late Future<List<Product>> products;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = productService.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          FutureBuilder<store>(
            future: StoreService.getStoreById(getStoreId()),
            builder: (context, AsyncSnapshot<store> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  child: const CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '¡Bienvenido!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data!.name +
                                        ' ' +
                                        snapshot.data!.lastName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        snapshot.data?.image ??
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => context.push(
                                  '/store/${snapshot.data!.id}/profile'),
                              child: const Text('ver perfil'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>
                        SearchProduct()
                )
            ),
            child: const Text('Buscar Productos'),
          ),
          Expanded(
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
          ),

        ],
      ),
    );
  }
}

void setStoreId(int id) {
  storeId = id;
}

int getStoreId() {
  return storeId;
}