import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/infrastructure/datasources/suppliers_datasource_impl.dart';
import 'package:ur_provider/features/providers/infrastructure/repositories/suppliers_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';

final suppliersRepositoryProvider = Provider<SuppliersRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final supplierRepository = SuppliersRepositoryImpl(
      SuppliersDatasourceImpl(accessToken: accessToken));

  return supplierRepository;
});
