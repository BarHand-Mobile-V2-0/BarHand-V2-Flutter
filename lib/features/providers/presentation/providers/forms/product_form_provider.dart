import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:flutter/widgets.dart';
import 'package:ur_provider/config/constants/environment.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';
import 'package:ur_provider/features/shared/shared.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  // final createUpdateCallback = ref.watch( productsRepositoryProvider ).createUpdateProduct;
  //final supplierNotifier = ref.watch(supplierProvider(supplier));
  // final createUpdateCallback = supplierNotifier.createOrUpdateSupplier;



  return ProductFormNotifier(
    product: product,
    //onSubmitCallback: createUpdateCallback,
  );
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
  onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(ProductFormState(
    id: product.id,
    name: product.name,
    category: product.category,
    image: product.image,
    price: product.price,
    description: product.description,
    numberOfSales: product.numberOfSales,
    available: product.available,
    supplierId: product.supplierId,
    rating: product.rating,
  ));


  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;


    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': (state.id == 0) ? null : state.id,
      'name': state.name,
      'category': state.category,
      'image': state.image,
      'price': state.price,
      'description': state.description,
      'numberOfSales': state.numberOfSales,
      'available': state.available,
      'supplierId': state.supplierId,
      'rating': state.rating,
    };



    try {
      return await onSubmitCallback!(productLike);
    } catch (e) {
      return false;
    }
  }
}

class ProductFormState {
  final bool isFormValid;
  final int? id;
  final String name;
  final String category;
  final String image;
  final int price;
  final String description;
  final int numberOfSales;
  final bool available;
  final int supplierId;
  final int rating;

  ProductFormState({
    this.isFormValid = false,
    this.id = 0,
    this.name = '',
    this.category = '',
    this.image = '',
    this.price = 0,
    this.description = '',
    this.numberOfSales = 0,
    this.available = false,
    this.supplierId = 0,
    this.rating = 0,
  });

  ProductFormState copyWith({
    bool? isFormValid,
    int? id,
    String? name,
    String? category,
    String? image,
    int? price,
    String? description,
    int? numberOfSales,
    bool? available,
    int? supplierId,
    int? rating,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        image: image ?? this.image,
        price: price ?? this.price,
        description: description ?? this.description,
        numberOfSales: numberOfSales ?? this.numberOfSales,
        available: available ?? this.available,
        supplierId: supplierId ?? this.supplierId,
        rating: rating ?? this.rating,
      );
}

