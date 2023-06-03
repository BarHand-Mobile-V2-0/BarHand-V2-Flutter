import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';
import 'package:ur_provider/features/shared/widgets/widgets.dart';

class SupplierScreen extends ConsumerWidget {
  final int supplierId;

  const SupplierScreen({super.key, required this.supplierId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Supplier Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierState = ref.watch(supplierProvider(supplierId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Supplier Details '),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))
          ],
        ),
        body: supplierState.isLoading
            ? const FullScreenLoader()
            : _SupplierView(supplier: supplierState.supplier!),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (supplierState.supplier == null) return;
            context.go('/supplier/${supplierState.supplier!.id}/products');
            ref
                .read(supplierFormProvider(supplierState.supplier!).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              showSnackbar(context);
            });
          },
          icon: const Icon(Icons.remove_red_eye),
          label: const Text("Ver productos del proveedor"),
        ),
      ),
    );
  }
}

class _SupplierView extends ConsumerWidget {
  final Supplier supplier;

  const _SupplierView({required this.supplier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierForm = ref.watch(supplierFormProvider(supplier));

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/no-image.jpg',
            image: supplierForm.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(
          supplierForm.supplierName,
          style: textStyles.titleSmall,
          textAlign: TextAlign.center,
        )),
        const SizedBox(height: 10),
        _SupplierInformation(supplier: supplier),
      ],
    );
  }
}

class _SupplierInformation extends ConsumerWidget {
  final Supplier supplier;

  const _SupplierInformation({required this.supplier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierForm = ref.watch(supplierFormProvider(supplier));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Provider general Data'),
          const SizedBox(height: 15),
          CustomProductField(
            label: 'Name',
            initialValue: supplierForm.name,
          ),
          CustomProductField(
            maxLines: 4,
            label: 'Decription',
            initialValue: supplier.description,
          ),
          const SizedBox(height: 10),
          CustomProductField(
            maxLines: 2,
            label: 'address',
            initialValue: supplierForm.address,
          ),
          const SizedBox(height: 10),
          CustomProductField(
            maxLines: 2,
            label: 'Category',
            initialValue: supplierForm.category,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
