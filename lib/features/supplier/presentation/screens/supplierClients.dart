import 'package:flutter/material.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';

class SupplierClients extends StatelessWidget {
  final int supplierId;

  const SupplierClients({Key? key, required this.supplierId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _SupplierClientsView(supplierId: supplierId),
    );
  }
}

class _SupplierClientsView extends StatefulWidget {
  final int supplierId;

  const _SupplierClientsView({Key? key, required this.supplierId})
      : super(key: key);

  @override
  _SupplierClientsViewState createState() => _SupplierClientsViewState();
}

class _SupplierClientsViewState extends State<_SupplierClientsView> {
  late Future<List<store>> stores;
  late TextEditingController searchController;
  late store viewStore;

  @override
  void initState() {
    super.initState();
    stores = StoreService.getAllStore();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: searchStore,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
          FutureBuilder<List<store>>(
            future: stores,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<store> storeList = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: storeList.length,
                  itemBuilder: (context, index) {
                    store store1 = storeList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          storeList.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Producto eliminado'),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: AspectRatio(
                                    aspectRatio: 0.5,
                                    child: Image.network(
                                      store1?.image ?? 'as',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IntrinsicHeight(
                                  child: ListTile(
                                    title: Text(store1.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(store1.storeName),
                                        Row(
                                          children: [
                                            const Icon(Icons.money_sharp),
                                            Text(store1.name +
                                                store1.lastName),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.message),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              padding:
                                              const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Edit Product',
                                                    style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 16.0),
                                                  const Text('Name'),
                                                  TextFormField(
                                                    initialValue: store1.name,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        store1.name = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                      height: 16.0),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                        'enviar mensaje'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void searchStore(String query) {
    setState(() {
      stores = StoreService.getAllStore().then((storeList) {
        return storeList
            .where((store) =>
        store.storeName.toLowerCase().contains(query.toLowerCase()) ||
            store.name.toLowerCase().contains(query.toLowerCase()) ||
            store.lastName.toLowerCase().contains(query.toLowerCase()) ||
            store.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }
}
