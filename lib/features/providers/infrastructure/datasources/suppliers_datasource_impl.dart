import 'package:dio/dio.dart';
import 'package:ur_provider/config/config.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/infrastructure/mappers/product_mapper.dart';
import 'package:ur_provider/features/providers/infrastructure/mappers/supplier_mapper.dart';

class SuppliersDatasourceImpl extends SuppliersDatasource {
  late final Dio dio;
  final String accessToken;

  SuppliersDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  ///PROVIDERS
  @override
  Future<Supplier> createUpdateProvider(Map<String, dynamic> productLike) {
    print('1');
    throw UnimplementedError();
  }

  @override
  Future<Supplier> getProviderById(int id) async {
    final response = await dio.get('/suppliers/$id');
    final data = response.data;
    ///print(response);
    final supplier = SupplierMapper.jsonToEntity(data);

    return supplier;
  }

  @override
   Future<List<Supplier>> getProviders() async {
    final response = await dio.get<List>('/suppliers');

    ///print(response);
    final List<Supplier> suppliers = [];
    for (final provider in response.data ?? []) {
      suppliers.add(SupplierMapper.jsonToEntity(provider));
    }
    return suppliers;
  }

  @override
  Future<List<Supplier>> searchProviderByTerm(String term) {
    print('2');
    throw UnimplementedError();
  }

  ///PROVIDERS
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    print('3');
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(int id) async {

    final response = await dio.get('/products/$id');
    final data = response.data;
    ///print(response);
    final product = ProductMapper.jsonToEntity(data);

    return product;
    print('4');
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await dio.get<List>('/products');

    print(response);
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductBySupplier(int id) async {
    final response = await dio.get<List>('/supplier/${id}/products');

    print(response);
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }
}
