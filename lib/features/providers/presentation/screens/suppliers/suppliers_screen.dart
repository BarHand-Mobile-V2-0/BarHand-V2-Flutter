import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/providers/presentation/widgets/widgets.dart';
import 'package:ur_provider/features/shared/shared.dart';
import 'package:ur_provider/features/providers/presentation/providers/providers.dart';


class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Providers'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: const _SuppliersView());
  }
}

class _SuppliersView extends ConsumerStatefulWidget {
  const _SuppliersView();

  @override
  _SuppliersViewState createState() => _SuppliersViewState();
}

class _SuppliersViewState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final suppliersState = ref.watch(suppliersProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: suppliersState.suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliersState.suppliers[index];
          return GestureDetector(
            onTap: () => context.push('/suppliers/${supplier.id}'),
            child: SupplierCard(supplier: supplier),
          );
        },
      ),
    );
  }
}
