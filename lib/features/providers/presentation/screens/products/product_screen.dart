import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/presentation/providers/forms/product_form_provider.dart';
import 'package:ur_provider/features/providers/presentation/providers/product/product.dart';

import '../../../../shared/widgets/custom_product_field.dart';
import '../../../../shared/widgets/full_screen_loader.dart';


class ProductScreen extends ConsumerWidget {
  final int supplierId;

  const ProductScreen({super.key, required this.supplierId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Supplier Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(supplierId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request Product '),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))
          ],
        ),
        body: productState.isLoading
            ? const FullScreenLoader()
            : _ProductView(product: productState.product!),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ref
                .read(productFormProvider(productState.product!).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              showSnackbar(context);
            });
          },
          icon: const Icon(Icons.send),
          label: const Text("Send Message"),
        ),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierForm = ref.watch(productFormProvider(product));

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
              supplierForm.name,
              style: textStyles.titleSmall,
              textAlign: TextAlign.center,
            )),
        const SizedBox(height: 10),
        _ProductInformation(product: product),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  final Product product;

  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productForm = ref.watch(productFormProvider(product));

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please Write to provider'),
          SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            maxLines: 15,
            initialValue: '',
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}