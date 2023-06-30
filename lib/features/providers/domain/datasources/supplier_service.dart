import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../config/core/services/http-common.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/store/presentation/lists/listSupplier.dart';


class  SupplierService {
  ///Stores
  static Future<List<Supplier>> getAllSupplier() async {
    final url = Uri.parse('$baseUrl/suppliers');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseJSON = json.decode(response.body);
      final allProduct = listSuppliers.listSupplier(responseJSON);
      return allProduct;
    }
    return <Supplier>[];
  }


  static Future<Supplier> getSupplierById(int id) async {
    final url = Uri.parse('$baseUrl/suppliers/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200)
      return Supplier.objJson(jsonDecode(response.body));
    else
      throw Exception('Error en servicio');
  }


  static Future<List<Supplier>> getProductBySupplierId(int id) async {
    final url = Uri.parse('$baseUrl/supplier/$id/products');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseJSON = json.decode(response.body);
      final allProduct = listSuppliers.listSupplier(responseJSON);
      return allProduct;
    }
    return <Supplier>[];
  }

  static Future<void> updateSupplier(dynamic updatedSupplier) async {
    final url = Uri.parse('$baseUrl/suppliers/${updatedSupplier.id}');
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(updatedSupplier.toJson()),
    );

    if (response.statusCode == 200) {
      print('Datos actualizados exitosamente');
    } else {
      throw Exception('Error en el servicio: ${response.statusCode}');
    }
  }
}