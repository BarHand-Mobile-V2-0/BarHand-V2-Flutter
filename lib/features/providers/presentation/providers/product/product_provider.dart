import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';

import 'products_repository_provider.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, int>((ref, productId) {
  final productsRepository = ref.watch(suppliersRepositoryProvider);

  return ProductNotifier(
      suppliersRepository: productsRepository, productId: productId);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final SuppliersRepository suppliersRepository;

  ProductNotifier({
    required this.suppliersRepository,
    required int productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 0,
      name: '',
      category: '',
      image: '',
      price: 0,
      description: '',
      numberOfSales: 0,
      available: false,
      supplierId: 0,
      rating: 0,
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }

      final product = await suppliersRepository.getProductById(state.id as int);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      // 404 product not found
      print(e);
    }
  }
}

class ProductState {
  final int id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    int? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
