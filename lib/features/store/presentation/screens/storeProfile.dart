import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';
import 'package:logger/logger.dart';

var storeId;

class StoreProfile extends StatelessWidget {
  final int storeId;

  const StoreProfile({super.key, required this.storeId});



  @override
  Widget build(BuildContext context) {
    setSupplierId(storeId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('supplier'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _SupplierView());
  }
}

class _SupplierView extends ConsumerStatefulWidget {
  const _SupplierView();

  @override
  _SupplierViewState createState() => _SupplierViewState();
}

class _SupplierViewState extends ConsumerState {
  late Future<store > _futureSupplier;
  final logger = Logger();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<store>(
              future: StoreService.getStoreById(getStorerId()),

              builder: (context, AsyncSnapshot<store> snapshot) {
                logger.d("Valor de snapshot.data!.name: ${snapshot.data!.name}");
                return Center(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            snapshot.data!.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Nombre: " +
                                snapshot.data!.name +
                                " " +
                                snapshot.data!.lastName,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data?.image ?? 'N/A',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Email:' + snapshot.data!.email,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Address: '+(snapshot.data?.address ?? 'N/A'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                              onPressed: () =>
                                  context
                                      .push(
                                      '/store/${getStorerId()}/editProfile'),
                              child: Text('editar'),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })));

  }

  @override
  void initState() {
    super.initState();
  }
}

void setSupplierId(int id) {
  storeId = id;
}

int getStorerId() {
  return storeId;
}
