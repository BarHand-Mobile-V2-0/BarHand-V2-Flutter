import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ur_provider/features/supplier/domain/entities/supplier.dart';
import 'package:ur_provider/features/supplier/domain/service/supplier_service.dart';
import 'package:ur_provider/features/supplier/presentation/screens/supplierProfile.dart';

class EditProfileSupplier extends StatefulWidget {
  final Supplier supplier;

  const EditProfileSupplier({Key? key, required this.supplier}) : super(key: key);

  @override
  _EditProfileSupplierState createState() => _EditProfileSupplierState();
}

class _EditProfileSupplierState extends State<EditProfileSupplier> {
  late Future<Supplier> supplier;
  bool isPasswordSecure = false;
  SupplierService supplierService = SupplierService();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    supplier = SupplierService.getSupplierById(widget.supplier.id);
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Supplier Name',
                  ),
                  initialValue: widget.supplier.supplierName,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.supplierName = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  initialValue: widget.supplier.email,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.email = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  initialValue: widget.supplier.address,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.address = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  initialValue: widget.supplier.name,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.name = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  initialValue: widget.supplier.lastName,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.lastName = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                  initialValue: widget.supplier.phone.toString(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.phone = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ruc',
                  ),
                  initialValue: widget.supplier.ruc.toString(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.phone = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                  ),
                  initialValue: widget.supplier.category,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.category = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.supplier.description,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.description = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                  ),
                  initialValue: widget.supplier.image,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.image = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  initialValue: widget.supplier.password,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      widget.supplier.password = value;
                      isPasswordSecure = _isPasswordSecure(value);
                    });
                  },
                ),
                SizedBox(height: 8),
                if (widget.supplier.password.isNotEmpty && !isPasswordSecure)
                  Text(
                    'La contraseña debe tener al menos 8 caracteres y contener una combinación de letras mayúsculas, letras minúsculas, números y caracteres especiales.',
                    style: TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed: () {
                    editData(widget.supplier);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupplierProfile(
                          supplierId: widget.supplier.id,
                        ),
                      ),
                    );
                  },
                  child: Text('Actualizar'),
                ),
              ],
            ),
          ),
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

  void editData(Supplier a) {
    SupplierService.updateSupplier(a);
  }
}
