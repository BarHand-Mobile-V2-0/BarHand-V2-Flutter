import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/store/presentation/lists/listSupplier.dart';
import '../../../../config/core/services/http-common.dart';

class supplierService{

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


}