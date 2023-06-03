import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/domain/entities/product.dart';

class SuppliersRepositoryImpl extends SuppliersRepository {
  final SuppliersDatasource datasource;

  SuppliersRepositoryImpl(this.datasource);

  ///PROVIDERS
  @override
  Future<Supplier> createUpdateProvider(Map<String, dynamic> productLike) {
    return datasource.createUpdateProvider(productLike);
  }

  @override
  Future<Supplier> getProviderById(int id) {
    return datasource.getProviderById(id);
  }

  @override
  Future<List<Supplier>> getProviders() {
    return datasource.getProviders();
  }

  @override
  Future<List<Supplier>> searchProviderByTerm(String term) {
    return datasource.searchProviderByTerm(term);
  }

  ///PRODUCTS
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(int id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductBySupplier(int id) {
    return datasource.getProductBySupplier(id);
  }

  @override
  Future<List<Product>> getProducts() {
    return datasource.getProducts();
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
}
