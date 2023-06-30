import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/providers/domain/datasources/supplier_service.dart';
import 'package:ur_provider/features/shared/widgets/side_menu.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';

import '../../../domain/entities/supplier.dart';

var supplierId;

class EditProfileSupplier extends StatelessWidget {
  final int supplierId;

  const EditProfileSupplier({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    setSupplierId(supplierId);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('supplier'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _EditSupplierProfileView());
  }
}

class _EditSupplierProfileView extends ConsumerStatefulWidget {
  const _EditSupplierProfileView();

  @override
  _EditSupplierProfileViewState createState() => _EditSupplierProfileViewState();
}

class _EditSupplierProfileViewState extends ConsumerState {
  //late Future<store> _futureSupplier;
  var supplierEdit = {};
  late Supplier suppliers;
  bool isPasswordSecure = false;
  SupplierService supplierService = new SupplierService();

  void fetchStoreData() async {
    try {
      final response = await SupplierService.getSupplierById(getSupplierId());
      setState(() {
        suppliers = response;
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
                initialValue: suppliers.name,
                onChanged: (value) {
                  setState(() {
                    suppliers.name = value;
                    // Actualizar la variable o hacer cualquier otra acción aquí
                    // Puedes acceder al valor ingresado mediante _textFieldController.text
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Valor de la variable: $suppliers',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                initialValue: suppliers.email,
                onChanged: (value) {
                  setState(() {
                    suppliers.email = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                initialValue: suppliers.address,
                onChanged: (value) {
                  setState(() {
                    suppliers.address = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                initialValue: suppliers.name,
                onChanged: (value) {
                  setState(() {
                    suppliers.name = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lastname',
                ),
                initialValue: suppliers.lastName,
                onChanged: (value) {
                  setState(() {
                    suppliers.lastName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                initialValue: suppliers.phone.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {
                    suppliers.phone = value as int;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                initialValue: suppliers.image,
                onChanged: (value) {
                  setState(() {
                    suppliers.image = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                initialValue: suppliers.password,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    suppliers.password = value;
                    isPasswordSecure = _isPasswordSecure(value);
                  });
                },
              ),
              SizedBox(height: 8),
              if (suppliers.password.isNotEmpty && !isPasswordSecure)
                Text(
                  'La contraseña debe tener al menos 8 caracteres y contener una combinación de letras mayúsculas, letras minúsculas, números y caracteres especiales.',
                  style: TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: () => {
                  editData(suppliers),
                  context.push('/supplier/${suppliers.id}/profile'),
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
    SupplierService.updateSupplier(stores);//editar

  }
}


/**/

void setSupplierId(int id) {
  supplierId = id;
}

int getSupplierId() {
  return supplierId;
}
