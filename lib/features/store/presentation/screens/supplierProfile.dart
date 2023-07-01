import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/store/presentation/screens/storesViewProduct.dart';

import 'package:ur_provider/features/supplier/domain/entities/supplier.dart';
import 'package:ur_provider/features/supplier/domain/service/supplier_service.dart';
import 'package:ur_provider/features/supplier/presentation/screens/productsBySupplier.dart';

import '../../../shared/widgets/side_menu.dart';

var supplierId;

class SupplierProfileByStore extends StatelessWidget {
  final int supplierId;

  const SupplierProfileByStore({Key? key, required this.supplierId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('supplier'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: _SupplierView(supplierId: supplierId));
  }
}

class _SupplierView extends StatefulWidget {
  final int supplierId;

  const _SupplierView({Key? key, required this.supplierId})
      : super(key: key);

  @override
  _SupplierViewState createState() => _SupplierViewState();
}

class _SupplierViewState extends State<_SupplierView> {
  late Future<Supplier> _futureSupplier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),

            child: FutureBuilder<Supplier>(
              future: SupplierService.getSupplierById(widget.supplierId),
              builder: (context, AsyncSnapshot<Supplier> snapshot) => Center(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          snapshot.data!.supplierName,
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
                          'Email:' + snapshot.data!.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Address:' + (snapshot.data?.address ?? 'N/A'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ruc:' + snapshot.data!.ruc.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Address:' + (snapshot.data?.address ?? 'n/A'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Category::' + (snapshot.data?.category ?? 'N/A'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          snapshot.data?.description ?? 'sin informacion',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!.phone.toString(),
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
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoreViewProduct(supplierId: widget.supplierId ),
                              ),
                            ),
                            child: Text('Productos'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            child: Text('detalles'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    _futureSupplier= SupplierService.getSupplierById(widget.supplierId);
  }
}


