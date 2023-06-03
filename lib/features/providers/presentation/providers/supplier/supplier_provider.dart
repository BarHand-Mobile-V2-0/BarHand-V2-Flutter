import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/supplier/suppliers_repository_provider.dart';

final supplierProvider = StateNotifierProvider.autoDispose
    .family<SupplierNotifier, SupplierState, int>((ref, supplierId) {
  final suppliersRepository = ref.watch(suppliersRepositoryProvider);

  return SupplierNotifier(
      suppliersRepository: suppliersRepository, supplierId: supplierId);
});

class SupplierNotifier extends StateNotifier<SupplierState> {
  final SuppliersRepository suppliersRepository;

  SupplierNotifier({
    required this.suppliersRepository,
    required int supplierId,
  }) : super(SupplierState(id: supplierId)) {
    loadSupplier();
  }

  Supplier newEmptySupplier() {
    return Supplier(
        id: 0,
        supplierName: '',
        name: '',
        lastName: '',
        email: '',
        address: '',
        ruc: 0,
        category: 'limpieza',
        description: '',
        phone: 0,
        password: '',
        image: '',
        likes: 0);
  }

  Future<void> loadSupplier() async {
    try {
      if (state.id == 0) {
        state = state.copyWith(
          isLoading: false,
          supplier: newEmptySupplier(),
        );
        return;
      }

      final supplier =
          await suppliersRepository.getProviderById(state.id as int);

      state = state.copyWith(isLoading: false, supplier: supplier);
    } catch (e) {
      // 404 product not found
      print(e);
    }
  }


  Future<bool> createOrUpdateSupplier(Map<String, dynamic> supplierData) async {
    try {
      print('DONE');
      // If the method completes without throwing an exception, we can assume it succeeded.
      return true;
    } catch (e) {
      // If there was an error, log it and return false.
      print('Failed to create or update supplier: $e');
      return false;
    }
  }
}

class SupplierState {
  final int id;
  final Supplier? supplier;
  final bool isLoading;
  final bool isSaving;

  SupplierState({
    required this.id,
    this.supplier,
    this.isLoading = true,
    this.isSaving = false,
  });

  SupplierState copyWith({
    int? id,
    Supplier? supplier,
    bool? isLoading,
    bool? isSaving,
  }) =>
      SupplierState(
        id: id ?? this.id,
        supplier: supplier ?? this.supplier,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
