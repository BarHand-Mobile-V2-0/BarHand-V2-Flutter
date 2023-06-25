import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';

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
  //late Future<store> _futureSupplier;
  var storeEdit = {};
  late store stores;
  bool isPasswordSecure = false;
  StoreService storeService = new StoreService();

  void fetchStoreData() async {
    try {
      final response = await StoreService.getStoreById(getStoreId());
      setState(() {
        stores = response;
      });
    } catch (e) {
      print('Error fetching store data: $e');
    }
  }

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
                initialValue: stores.name,
                onChanged: (value) {
                  setState(() {
                    stores.name = value;
                    // Actualizar la variable o hacer cualquier otra acción aquí
                    // Puedes acceder al valor ingresado mediante _textFieldController.text
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Valor de la variable: $stores',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                initialValue: stores.email,
                onChanged: (value) {
                  setState(() {
                    stores.email = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                initialValue: stores.address,
                onChanged: (value) {
                  setState(() {
                    stores.address = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                initialValue: stores.name,
                onChanged: (value) {
                  setState(() {
                    stores.name = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lastname',
                ),
                initialValue: stores.lastName,
                onChanged: (value) {
                  setState(() {
                    stores.lastName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                initialValue: stores.phone.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {
                    stores.phone = value as int;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                initialValue: stores.image,
                onChanged: (value) {
                  setState(() {
                    stores.image = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                initialValue: stores.password,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    stores.password = value;
                    isPasswordSecure = _isPasswordSecure(value);
                  });
                },
              ),
              SizedBox(height: 8),
              if (stores.password.isNotEmpty && !isPasswordSecure)
                Text(
                  'La contraseña debe tener al menos 8 caracteres y contener una combinación de letras mayúsculas, letras minúsculas, números y caracteres especiales.',
                  style: TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: () => {
                  editData(stores),
                  context.push('/store/${stores.id}/profile'),
                },
                child: Text('actualizar'),
              ),
            ],
          ),
        ));
  }

  bool _isPasswordSecure(String value) {
    if (value.length < 8) {
      return false;
    }
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasNumber = false;
    bool hasSpecialChar = false;
    for (int i = 0; i < value.length; i++) {
      String char = value[i];
      if (char.toUpperCase() != char.toLowerCase()) {
        if (char == char.toUpperCase()) {
          hasUppercase = true;
        } else if (char == char.toLowerCase()) {
          hasLowercase = true;
        }
      } else if (int.tryParse(char) != null) {
        hasNumber = true;
      } else {
        hasSpecialChar = true;
      }
    }
    return hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
  }

  @override
  void initState() {
    super.initState();
    fetchStoreData();
  }

  void editData(dynamic stores){
    StoreService.updateStore(stores);//editar

  }
}


/**/

void setStoreId(int id) {
  storeId = id;
}

int getStoreId() {
  return storeId;
}
