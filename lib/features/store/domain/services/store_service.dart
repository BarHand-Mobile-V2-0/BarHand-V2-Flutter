
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../config/core/services/http-common.dart';
import 'package:ur_provider/features/store/domain/entities/store.dart';
import 'package:ur_provider/features/store/presentation/lists/listStore.dart';


class  StoreService {
  ///Stores
  static Future<List<store>> getAllStore() async {
    final url = Uri.parse('$baseUrl/stores');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseJSON = json.decode(response.body);
      final allProduct = listStores.listStore(responseJSON);
      return allProduct;
    }
    return <store>[];
  }


  static Future<store> getStoreById(int id) async {
    final url = Uri.parse('$baseUrl/stores/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200)
      return store.objJson(jsonDecode(response.body));
    else
      throw Exception('Error en servicio');
  }


  static Future<List<store>> getProductBySupplierId(int id) async {
    final url = Uri.parse('$baseUrl/supplier/$id/products');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseJSON = json.decode(response.body);
      final allProduct = listStores.listStore(responseJSON);
      return allProduct;
    }
    return <store>[];
  }

  static Future<void> updateStore(dynamic updatedStore) async {
    final url = Uri.parse('$baseUrl/stores/${updatedStore.id}');
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(updatedStore.toJson()),
    );

    if (response.statusCode == 200) {
      print('Datos actualizados exitosamente');
    } else {
      throw Exception('Error en el servicio: ${response.statusCode}');
    }
  }
}


