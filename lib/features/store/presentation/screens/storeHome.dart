import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ur_provider/features/store/domain/domain.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';
import 'package:ur_provider/features/shared/widgets/widgets.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';

var storeId;

class StoreHome extends StatelessWidget {
  final int storeId;

  const StoreHome({super.key, required this.storeId});

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
        body: const _StoreHomeView());
  }
}

class _StoreHomeView extends ConsumerStatefulWidget {
  const _StoreHomeView();

  @override
  _StoreHomeViewState createState() => _StoreHomeViewState();
}

class _StoreHomeViewState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder<store>(
            future: StoreService.getStoreById(getStoreId()),
            builder: (context, AsyncSnapshot<store> snapshot) {
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
                          Text(
                            '¡Bienvenido!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  snapshot.data!.name +
                                      ' ' +
                                      snapshot.data!.lastName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(width: 50), // Espacio entre los widgets
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
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
                              )
                            ],

                          ),
                          ElevatedButton(
                            onPressed: () =>
                                context
                                    .push(
                                    '/store/${snapshot.data!.id}/profile'),

                            child: Text('ver perfil'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        FutureBuilder(
          initialData: [],
          future: productService.getAllProduct(),
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
                                        '/store/${getStoreId()}/Products/${product.id}'),
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

void setStoreId(id) {
  storeId = id;
}

int getStoreId() {
  return storeId;
}
/*FutureBuilder(

                  initialData: [],
                  future: supplierService.getAllSupplier(),
                  builder: (context,AsyncSnapshot<List>snapshot) {
                    return ListView.builder(
                        itemCount:suppliersState.suppliers.length,
                        itemBuilder:(context,index){
                          final productos=suppliersState.suppliers[index];
                          return ListTile(
                            title: Text('ID: '+productos.image.toString()),
                          );
                        });
                  }
              ),*/

/*FutureBuilder(initialData: [],
                future: productService.getAllProduct(),
                builder: (context,AsyncSnapshot<List>snapshot)
                =>
                    Column(

                  children: [
                    SizedBox(
                      height: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Text('Best Provider',
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                    ),
                    CarouselSlider.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index,realIndex){
                          var supplier = suppliersState.suppliers[ index];
                          return
                            Column(
                              children: [
                                Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(supplier.supplierName),
                                      Text(supplier.description),
                                      Image(
                                        image: NetworkImage(supplier.image.toString()),
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('Ver Producto'),
                                            onPressed: () {/* ... */},
                                          ),
                                          const SizedBox(width: 8),
                                          TextButton(
                                            child: const Text('añadir'),
                                            onPressed: () {/* ... */},
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
              ),*/
