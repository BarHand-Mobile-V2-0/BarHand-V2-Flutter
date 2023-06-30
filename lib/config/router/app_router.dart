import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/auth/auth.dart';
import 'package:ur_provider/features/providers/presentation/screens/screens.dart';
import 'package:ur_provider/features/providers/presentation/screens/suppliers/editProfileSupplier.dart';
import 'package:ur_provider/features/providers/presentation/screens/suppliers/supplierInventory.dart';
import 'package:ur_provider/features/providers/presentation/screens/suppliers/supplierProfilee.dart';
import 'package:ur_provider/features/store/presentation/screens/editProfileStore.dart';
import 'package:ur_provider/features/store/presentation/screens/storeHome.dart';
import 'package:ur_provider/features/store/presentation/screens/storeProfile.dart';
import 'package:ur_provider/features/store/presentation/screens/supplierProfile.dart';

import '../../features/inventory/presentation/product_card_by_store.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    ///* Home Routes -> PROVIDERS
    GoRoute(
      path: '/suppliers',
      builder: (context, state) => const SuppliersScreen(),
    ),
    GoRoute(
      path: '/suppliers/:id/home',
      builder: (context, state) => SupplierHome(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '/supplier/:id/products',
      builder: (context, state) => ProductsScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

    ///* PRODUCTS Routes
    GoRoute(
      path: '/products/:id',
      builder: (context, state) => ProductScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

    GoRoute(
      path: '/supplier/:id/products',
      builder: (context, state) => SupplierInventory(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '/supplier/:id/profile',
      builder: (context, state) => SupplierProfile(
        supplierId: int.parse(state.params['id'] ?? '0'),

      ),
    ),
    GoRoute(
      path: '/supplier/:id/editSupplierProfile',
      builder: (context, state) => EditProfileSupplier(
        supplierId: int.parse(state.params['id'] ?? '0'),

      ),
    ),


    ///* STORES Routes
    GoRoute(
      path: '/store/:id/home',
      builder: (context, state) => StoreHome(
        storeId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

    GoRoute(
      path: '/store/:storeId/products/:productId',
      builder: (context, state) => ProductScreen1(
        storeId: int.parse(state.params['storeId'] ?? '0'),
        productId: int.parse(state.params['productId'] ?? '0'),

      ),
    ),

    GoRoute(
      path: '/store/supplier/:supplierId',
      builder: (context, state) => SupplierProfileByStore(
        supplierId: int.parse(state.params['supplierId'] ?? '0'),

      ),
    ),

    GoRoute(
      path: '/store/:id/profile',
      builder: (context, state) => StoreProfile(
        storeId: int.parse(state.params['id'] ?? '0'),

      ),
    ),

    GoRoute(
      path: '/store/:id/editProfile',
      builder: (context, state) => EditProfileStore(
        storeId: int.parse(state.params['id'] ?? '0'),

      ),
    ),






  ],
);
