import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/auth/auth.dart';
import 'package:ur_provider/features/inventory/service/product_service.dart';
import 'package:ur_provider/features/store/presentation/screens/editProfileStore.dart';
import 'package:ur_provider/features/store/presentation/screens/storeHome.dart';
import 'package:ur_provider/features/store/presentation/screens/storeProfile.dart';
import 'package:ur_provider/features/store/presentation/screens/supplierProfile.dart';
import 'package:ur_provider/features/supplier/presentation/screens/supplierHome.dart';

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

    ///* Home Routes -> Supplier
    /*GoRoute(
      path: '/suppliers',
      builder: (context, state) => const SuppliersScreen(),
    ),*/
   GoRoute(
      path: '/supplier/:id/home',
      builder: (context, state) => SupplierHome(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

    ///* PRODUCTS Routes
   /* GoRoute(
      path: '/products/:id',
      builder: (context, state) => ProductScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),*/
/*
    GoRoute(
      path: '/supplier/:id/products',
      builder: (context, state) => ProductsScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

 */


    ///* STORES Routes
    GoRoute(
      path: '/store/:id/home',
      builder: (context, state) => StoreHome(
        storeId: int.parse(state.params['id'] ?? '0'),
      ),
    ),

    /*GoRoute(
      path: '/store/:storeId/products/:productId',
      builder: (context, state) => ProductScreen1(
        storeId: int.parse(state.params['storeId'] ?? '0'),
        product: productService.getProductById(int.parse(state.params['productId']?? 1)),

      ),
    ),*/

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

    /*GoRoute(
      path: '/store/:id/editProfile',
      builder: (context, state) => EditProfileStore(
        storeId: int.parse(state.params['id'] ?? '0'),

      ),
    ),*/



   /* GoRoute(
      path: '/supplier/:id/products',
      builder: (context, state) => ProductsScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),*/


  ],
);
