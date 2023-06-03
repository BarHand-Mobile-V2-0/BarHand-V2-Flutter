import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';
import 'package:ur_provider/features/shared/shared.dart';

import '../../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final int supplierId;
  const ProductsScreen({Key? key, required this.supplierId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ProductsView(supplierId: supplierId),
      /*floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),*/
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  final int supplierId;

  const _ProductsView({required this.supplierId});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<_ProductsView> {
  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider(widget.supplierId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];
          return GestureDetector(
            onTap: () => context.push('/products/${product.id}'),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}

