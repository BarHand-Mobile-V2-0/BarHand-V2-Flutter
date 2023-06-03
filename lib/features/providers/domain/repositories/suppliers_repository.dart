import '../entities/product.dart';

import '../entities/supplier.dart';

abstract class SuppliersRepository {
  //Providers
  Future<List<Supplier>> getProviders();

  Future<Supplier> getProviderById(int id);

  Future<List<Supplier>> searchProviderByTerm(String term);

  Future<Supplier> createUpdateProvider(Map<String, dynamic> productLike);

  //Products
  Future<List<Product>> getProducts();

  Future<List<Product>> getProductBySupplier(int id);

  Future<Product> getProductById(int id);

  Future<List<Product>> searchProductByTerm(String term);

  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
