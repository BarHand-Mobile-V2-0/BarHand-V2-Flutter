import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:flutter/widgets.dart';
import 'package:ur_provider/config/constants/environment.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';
import 'package:ur_provider/features/shared/shared.dart';

final supplierFormProvider = StateNotifierProvider.autoDispose
    .family<SupplierFormNotifier, SupplierFormState, Supplier>((ref, supplier) {
  // final createUpdateCallback = ref.watch( productsRepositoryProvider ).createUpdateProduct;
  //final supplierNotifier = ref.watch(supplierProvider(supplier));
 // final createUpdateCallback = supplierNotifier.createOrUpdateSupplier;



  return SupplierFormNotifier(
    supplier: supplier,
    //onSubmitCallback: createUpdateCallback,
  );
});

class SupplierFormNotifier extends StateNotifier<SupplierFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
      onSubmitCallback;

  SupplierFormNotifier({
    this.onSubmitCallback,
    required Supplier supplier,
  }) : super(SupplierFormState(
          id: supplier.id,
          supplierName: supplier.supplierName,
          name: supplier.name,
          lastName: supplier.lastName,
          email: supplier.email,
          address: supplier.address,
          ruc: supplier.ruc,
          category: supplier.category,
          description: supplier.description,
          phone: supplier.phone,
          password: supplier.password,
          image: supplier.image,
          likes: supplier.likes,
        ));

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;

    // TODO: regresar
    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': (state.id == 0) ? null : state.id,
      'supplierName': state.supplierName,
      'name': state.name,
      'lastName': state.lastName,
      'email': state.email,
      'address': state.address,
      'ruc': state.ruc,
      'category': state.category,
      'description': state.description,
      'phone': state.phone,
      'password': state.password,
      'image': state.image,
      'likes': state.likes,
    };

    try {
      return await onSubmitCallback!(productLike);
    } catch (e) {
      return false;
    }
  }
}

class SupplierFormState {
  final bool isFormValid;
  final int? id;
  final String supplierName;
  final String name;
  final String lastName;
  final String email;
  final String address;
  final int ruc;
  final String category;
  final String description;
  final int phone;
  final String password;
  final String image;
  final int likes;

  SupplierFormState({
    this.isFormValid = false,
    this.id = 0,
    this.supplierName = '',
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.address = '',
    this.ruc = 0,
    this.category = '',
    this.description = '',
    this.phone = 0,
    this.password = '',
    this.image = '',
    this.likes = 0,
  });

  SupplierFormState copyWith({
    bool? isFormValid,
    int? id,
    String? supplierName,
    String? name,
    String? lastName,
    String? email,
    String? address,
    int? ruc,
    String? category,
    String? description,
    int? phone,
    String? password,
    String? image,
    int? likes,
  }) =>
      SupplierFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        supplierName: supplierName ?? this.supplierName,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        address: address ?? this.address,
        ruc: ruc ?? this.ruc,
        description: description ?? this.description,
        category: category ?? this.category,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        image: image ?? this.image,
        likes: likes ?? this.likes,
      );
}
