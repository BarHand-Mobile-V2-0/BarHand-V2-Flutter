import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';

var storeId;

class EditProfileStore extends StatelessWidget {
  final int storeId;

  const EditProfileStore({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    setStoreId(storeId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('supplier'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _EditStoreProfileView());
  }
}

class _EditStoreProfileView extends ConsumerStatefulWidget {
  const _EditStoreProfileView();

  @override
  _EditStoreProfileViewState createState() => _EditStoreProfileViewState();
}

class _EditStoreProfileViewState extends ConsumerState {
  late Future<store> _futureSupplier;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'StoreName',
                ),
                controller: _textFieldController,
                onChanged: (value) {
                  setState(() {
                    // Actualizar la variable o hacer cualquier otra acción aquí
                    // Puedes acceder al valor ingresado mediante _textFieldController.text
                  });
                },

              ),
              SizedBox(height: 16),
              Text(
                'Valor de la variable: ${_textFieldController.text}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),

              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Lastname',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
        ));
  }
}

/**/

void setStoreId(int id) {
  storeId = id;
}

int getStoreId() {
  return storeId;
}

