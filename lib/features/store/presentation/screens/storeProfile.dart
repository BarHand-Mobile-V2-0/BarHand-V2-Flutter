import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';
import 'package:logger/logger.dart';
import 'package:ur_provider/features/store/presentation/screens/editProfileStore.dart';

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
          title: const Text('Store'),
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
  late store tienda;
  final logger = Logger();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edtar perfil'),
        ),
        body:SingleChildScrollView(
            child: Column(
                children: [

        Container(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<store>(
              future: StoreService.getStoreById(getStoreId()),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: const CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data1 = snapshot.data;
                  tienda=data1!;

                  return Center(
                    child: Card(
                      child:

                      Column(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0),
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
                              'Address: ' + (snapshot.data?.address ?? 'N/A'),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileStore( tienda: tienda),
                                      ),
                                    ),
                                child: Text('editar'),
                              ),

                            ],
                          ),
                        ],
                      ),


                    ),
                  );
                }
              }))
        ]
    )
        )

    );
  }

  int getStoreId() {
    return storeId;
  }
}

void setSupplierId(int id) {
  storeId = id;
}


