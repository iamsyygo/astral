import 'package:astral/services/network/dio_client.dart';

class AuthApi {
  final _dio = DioClient.instance;

  Future<bool?> sendCodeWithEmail(String email) async {
    return await _dio.post<bool>(
      '/api/authorize/code',
      data: {'email': email, 'type': 'login'},
    );
  }

  Future<Map<String, dynamic>?> loginWithEmail(
      String email, String code) async {
    return await _dio.post<Map<String, dynamic>>(
      '/api/authorize/login/email',
      data: {
        'email': email,
        'code': code,
      },
    );
  }
}
