import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ur_provider/features/inventory/domain/entities/product.dart';
import 'package:ur_provider/features/store/presentation/lists/listProduct.dart';
import '../../../config/core/services/http-common.dart';

class productService{
  static Future<List<Product>> getAllProduct() async{
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(url, headers: headers);
    if(response.statusCode==200){
      final responseJSON=json.decode(response.body);
      final allProduct=listProducts.listProduct(responseJSON);
      return allProduct;
    }
    return <Product>[];
  }


  static Future<Product> getProductById(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final response = await http.get(url, headers: headers);
    if(response.statusCode==200)
       return Product.objJson(jsonDecode(response.body));
    else
      throw Exception('Error en servicio');
  }
  static Future<List<Product>> getProductBySupplierId(int id) async {
    final url = Uri.parse('$baseUrl/supplier/$id/products');
    final response = await http.get(url, headers: headers);
    if(response.statusCode==200){
      final responseJSON=json.decode(response.body);
      final allProduct=listProducts.listProduct(responseJSON);
      return allProduct;
    }
    return <Product>[];
  }



}



