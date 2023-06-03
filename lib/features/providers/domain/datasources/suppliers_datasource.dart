import '../entities/supplier.dart';
import '../entities/product.dart';

abstract class SuppliersDatasource {
  ///PROVIDERS
  Future<List<Supplier>> getProviders();

  Future<Supplier> getProviderById(int id);

  Future<List<Supplier>> searchProviderByTerm(String term);

  Future<Supplier> createUpdateProvider(Map<String, dynamic> productLike);

  ///PRODUCTS
  Future<List<Product>> getProducts();

  Future<Product> getProductById(int id);

  Future<List<Product>> getProductBySupplier(int id);

  Future<List<Product>> searchProductByTerm(String term);

  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
