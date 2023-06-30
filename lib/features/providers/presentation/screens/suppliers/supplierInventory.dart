import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/side_menu.dart';
import '../../../../store/presentation/screens/storeProfile.dart';
import '../../../domain/datasources/supplier_service.dart';
import '../../../domain/entities/supplier.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';


var supplierId;
class SupplierInventory extends StatelessWidget {
  final int supplierId;
  const SupplierInventory({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    setSupplierId(supplierId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Iventario'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _SupplierInventoryView());
  }
}
class _SupplierInventoryView extends ConsumerStatefulWidget {
  const _SupplierInventoryView();

  @override
  _SupplierInventoryViewState createState() => _SupplierInventoryViewState();
}
class _SupplierInventoryViewState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
          initialData: [],
          future: productService.getProductBySupplierId(supplierId),
          builder: (context, AsyncSnapshot<List> snapshot) => Column(
            children: [
              SizedBox(
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text(
                'Best Product',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
              CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index, realIndex) {
                    var product = snapshot.data![index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(product.name),
                              Image(
                                image: NetworkImage(product.image.toString()),
                                fit: BoxFit.cover,
                                height: 190,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Ver Producto'),
                                    onPressed: () => context.push(
                                        '/suppliers/${getSupplierId()}/products/${product.id}'),
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
                        ),
                      ],
                    );

                    //return  Image.network(product.image.toString());
                  },
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    autoPlayInterval: Duration(seconds: 3),
                    scrollDirection: Axis.horizontal,
                  ))
            ],
          ),
        ),
      ]),
    );
  }
  @override
  void initState() {
    super.initState();
  }
}


void setSupplierId(id) {
  supplierId = id;
}

int getSupplierId() {
  return supplierId;
}
