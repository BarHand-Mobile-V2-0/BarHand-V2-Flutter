import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/supplier/suppliers_repository_provider.dart';


final productsProvider =
StateNotifierProvider.family<ProductsNotifier, ProductsState, int>((ref, supplierId) {
  final productsRepository = ref.watch(suppliersRepositoryProvider);
  return ProductsNotifier(supplierId: supplierId, productsRepository: productsRepository);
});

class ProductsState {
  final bool isLoading;
  final List<Product> products;

  ProductsState({this.isLoading = false, this.products = const []});

  ProductsState copyWith({
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final int supplierId;
  final SuppliersRepository productsRepository;

  ProductsNotifier({required this.supplierId, required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }


  Future loadNextPage() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductBySupplier(supplierId);

    state = state.copyWith(
      products: products,
      isLoading: false,
    );
  }
}
