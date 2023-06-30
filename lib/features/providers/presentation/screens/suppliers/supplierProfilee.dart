import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/providers/domain/entities/supplier.dart';
import 'package:ur_provider/features/providers/domain/datasources/supplier_service.dart';
import 'package:logger/logger.dart';

var supplierId;

class SupplierProfile extends StatelessWidget {
  final int supplierId;

  const SupplierProfile({super.key, required this.supplierId});



  @override
  Widget build(BuildContext context) {
    setSupplierId(supplierId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Profile'),
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
  late Future<Supplier> _futureSupplier;
  final logger = Logger();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<Supplier>(
                future: SupplierService.getSupplierById(getSupplierId()),

                builder: (context, AsyncSnapshot<Supplier> snapshot) {
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
                                        '/supplier/${getSupplierId()}/editSupplierProfile'),
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
  supplierId = id;
}

int getSupplierId() {
  return supplierId;
}
