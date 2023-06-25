import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';

import '../../shared/widgets/side_menu.dart';

var productId;

class ProductScreen1 extends StatelessWidget {
  final int storeId;
  final int productId;

  const ProductScreen1(
      {super.key, required this.storeId, required this.productId});

  @override
  Widget build(BuildContext context) {
    setProductId(productId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Stores'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _ProductView());
  }
}

class _ProductView extends ConsumerStatefulWidget {
  const _ProductView();

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState {
  late Future<Product> _futureProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FutureBuilder<Product>(
      future: productService.getProductById(getProductId()),
      builder: (context, AsyncSnapshot<Product> snapshot) => Center(
        child: Card(
          margin: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),

                height: 200,
                width: double.infinity,
                child:

                Image.network(
                  snapshot.data!.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data!.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  snapshot.data!.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ' \$ '+  snapshot.data!.price.toString(),
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
                    onPressed: ()=>context.push('/store/supplier/${snapshot.data!.supplierId}'),
                    child: Text('Supplier'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () { },
                    child: Text('detalles'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )));
  }

  @override
  void initState() {
    super.initState();
  }
}

void setProductId(int id) {
  productId = id;
}

int getProductId() {
  return productId;
}

