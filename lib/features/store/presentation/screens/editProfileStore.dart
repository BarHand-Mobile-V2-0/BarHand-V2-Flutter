import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/domain/services/store_service.dart';
import 'package:ur_provider/features/store/presentation/screens/storeProfile.dart';


class EditProfileStore extends StatefulWidget {
  final store tienda;

  const EditProfileStore({Key? key, required this.tienda}) : super(key: key);

  @override
  _EditProfileStoreState createState() => _EditProfileStoreState();
}

class _EditProfileStoreState extends State<EditProfileStore> {
  late Future<store> stores;
  bool isPasswordSecure = false;
  StoreService storeService = StoreService();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stores=StoreService.getStoreById(widget.tienda.id) ;
  }
  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Store Name',
              ),
              initialValue: widget.tienda.name,
              onChanged: (value) {
                setState(() {
                  widget.tienda.name = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              initialValue: widget.tienda.email,
              onChanged: (value) {
                setState(() {
                  widget.tienda.email = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              initialValue: widget.tienda.address,
              onChanged: (value) {
                setState(() {
                  widget.tienda.address = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              initialValue: widget.tienda.name,
              onChanged: (value) {
                setState(() {
                  widget.tienda.name = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
              initialValue: widget.tienda.lastName,
              onChanged: (value) {
                setState(() {
                  widget.tienda.lastName = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
              initialValue: widget.tienda.phone.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  widget.tienda.phone = int.parse(value);
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              initialValue: widget.tienda.image,
              onChanged: (value) {
                setState(() {
                  widget.tienda.image = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              initialValue: widget.tienda.password,
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  widget.tienda.password = value;
                  isPasswordSecure = _isPasswordSecure(value);
                });
              },
            ),
            SizedBox(height: 8),
            if (widget.tienda.password.isNotEmpty && !isPasswordSecure)
              Text(
                'La contraseña debe tener al menos 8 caracteres y contener una combinación de letras mayúsculas, letras minúsculas, números y caracteres especiales.',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: ()  {
                 editData(widget.tienda);
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) =>
                         StoreProfile( storeId: widget.tienda.id,),
                   ),
                 );
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
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

  void editData(store a) {
    StoreService.updateStore(a);
  }
}