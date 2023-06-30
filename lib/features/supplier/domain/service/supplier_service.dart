
import 'dart:convert';
import 'package:ur_provider/features/supplier/presentation/lists/listSupplier.dart';
import 'package:http/http.dart' as http;
import 'package:ur_provider/config/core/services/http-common.dart';
import 'package:ur_provider/features/supplier/domain/entities/supplier.dart';

class SupplierService{

  static Future<List<Supplier>> getAllSupplier() async{
    final url = Uri.parse('$baseUrl/suppliers');
    final response = await http.get(url, headers: headers);
    if(response.statusCode==200){
      final responseJSON=json.decode(response.body);
      final allProduct=listSuppliers.listSupplier(responseJSON);
      return allProduct;
    }
    return <Supplier>[];
  }
  static Future<Supplier> getSupplierById(int id) async {
    final url = Uri.parse('$baseUrl/suppliers/$id');
    final response = await http.get(url, headers: headers);
    if(response.statusCode==200)
      return Supplier.objJson(jsonDecode(response.body));
    else
      throw Exception('Error en servicio');
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