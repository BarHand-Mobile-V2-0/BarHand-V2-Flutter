import 'package:flutter/material.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/supplier/domain/entities/supplier.dart';
import 'package:ur_provider/features/supplier/domain/service/supplier_service.dart';
import 'package:ur_provider/features/supplier/presentation/screens/supplierProfile.dart';

class SupplierHome extends StatelessWidget {
  final int supplierId;

  const SupplierHome({Key? key, required this.supplierId}) : super(key: key);

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
      body: _SupplierHomeView(supplierId: supplierId),
    );
  }
}

class _SupplierHomeView extends StatefulWidget {
  final int supplierId;

  const _SupplierHomeView({Key? key, required this.supplierId})
      : super(key: key);

  @override
  _SupplierHomeState createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<_SupplierHomeView> {
  late Supplier supplier;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<Supplier>(
                future: SupplierService.getSupplierById(widget.supplierId),
                builder: (context, AsyncSnapshot<Supplier> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              '¡Bienvenido!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.only(top: 20),
                              width: double.infinity,
                              child: Image.network(
                                snapshot.data?.image ?? 'N/A',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Email: ${snapshot.data?.email ?? 'N/a'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Address: ${snapshot.data?.address ?? 'N/A'}',
                                style: const TextStyle(
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SupplierProfile( supplierId: widget.supplierId),
                                      ),
                                    );
                                    // Implementar la lógica para editar el perfil
                                  },
                                  child: const Text('Ver Perfil'),
                                ),
                              ],
                            ),

                          ],


                        ),
                      ),
                    );
                  }
                }),

          //agregar mas componentes sis e desea
          ],
        ),
      ),
    );
  }
}

