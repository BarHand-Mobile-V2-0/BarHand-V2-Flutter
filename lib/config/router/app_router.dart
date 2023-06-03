import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/auth/auth.dart';
import 'package:ur_provider/features/providers/presentation/screens/screens.dart';

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
      path: '/suppliers/:id',
      builder: (context, state) => SupplierScreen(
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
      builder: (context, state) => ProductsScreen(
        supplierId: int.parse(state.params['id'] ?? '0'),
      ),
    ),
  ],
);
