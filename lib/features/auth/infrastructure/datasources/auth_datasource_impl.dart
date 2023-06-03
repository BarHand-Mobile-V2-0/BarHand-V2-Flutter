import 'package:dio/dio.dart';
import 'package:ur_provider/config/config.dart';
import 'package:ur_provider/features/auth/domain/domain.dart';
import 'package:ur_provider/features/auth/infrastructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://moisesmore75-001-site1.ftempurl.com/api/v1',
  ));

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/users/sign-in', data: {'email': email, 'password': password});
      print('response.data ${response}');
      final user = UserMapper.userJsonToEntity(response.data);
      print(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print(
            'Error de autenticación: ${e.response?.data['message'] ?? 'Credenciales incorrectas'}');
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        print('Error de conexión: Revisar conexión a internet');
        throw CustomError('Revisar conexión a internet');
      }
      print('Error no controlado: $e');
      throw Exception();
    } catch (e) {
      print('Error no controlado: $e');
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
