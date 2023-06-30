import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/infrastructure/datasources/suppliers_datasource_impl.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';
import 'package:ur_provider/features/shared/widgets/widgets.dart';
import 'package:ur_provider/features/providers/domain/datasources/suppliers_datasource.dart';
import 'package:ur_provider/features/providers/domain/repositories/suppliers_repository.dart';
import 'package:ur_provider/features/providers/infrastructure/datasources/suppliers_datasource_impl.dart';
import 'package:ur_provider/features/providers/infrastructure/repositories/suppliers_repository_impl.dart';
import 'package:ur_provider/features/providers/domain/datasources/supplier_service.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';
var supplierId;

class SupplierHome extends StatelessWidget {
  final int supplierId;

  const SupplierHome({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    setSupplierId(supplierId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Supplier'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _SupplierHomeView());
  }
}

class _SupplierHomeView extends ConsumerStatefulWidget {
  const _SupplierHomeView();

  @override
  _SupplierHomeViewState createState() => _SupplierHomeViewState();
}

class _SupplierHomeViewState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Agrega un color de fondo
        child: Column(
          children: [
            FutureBuilder<Supplier>(
              future: SupplierService.getSupplierById(getSupplierId()),
              builder: (context, AsyncSnapshot<Supplier> snapshot) {
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
                                color: Colors.black, // Agrega un color al texto
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                SizedBox(width: 50),
                                Container(
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
                              ],
                            ),
                            SizedBox(height: 16), // Agrega un espacio vertical entre el nombre y la imagen
                            ElevatedButton(
                              onPressed: () => context.push(
                                  '/supplier/${snapshot.data!.id}/products'),
                              child: Text('Inventario'),
                            ),
                            SizedBox(height: 8), // Agrega un espacio vertical entre los botones
                            ElevatedButton(
                              onPressed: () => context.push(
                                  '/supplier/${snapshot.data!.id}/profile'),
                              child: Text('Perfil'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
