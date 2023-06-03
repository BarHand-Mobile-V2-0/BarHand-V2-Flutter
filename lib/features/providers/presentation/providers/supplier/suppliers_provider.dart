import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/supplier/suppliers_repository_provider.dart';


final suppliersProvider =
    StateNotifierProvider<SuppliersNotifier, SuppliersState>((ref) {
  final productsRepository = ref.watch(suppliersRepositoryProvider);
  return SuppliersNotifier(productsRepository: productsRepository);
});

class SuppliersState {
  final bool isLoading;
  final List<Supplier> suppliers;

  SuppliersState({this.isLoading = false, this.suppliers = const []});

  SuppliersState copyWith({
    bool? isLoading,
    List<Supplier>? suppliers,
  }) =>
      SuppliersState(
        isLoading: isLoading ?? this.isLoading,
        suppliers: suppliers ?? this.suppliers,
      );
}

class SuppliersNotifier extends StateNotifier<SuppliersState> {
  final SuppliersRepository productsRepository;

  SuppliersNotifier({required this.productsRepository})
      : super(SuppliersState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final suppliers = await productsRepository.getProviders();

    state = state.copyWith(
      suppliers: suppliers,
      isLoading: false,
    );
  }
}
