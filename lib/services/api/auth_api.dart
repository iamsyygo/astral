import 'package:astral/services/dio/dio_client.dart';
import 'package:astral/services/dio/models/api_response.dart';
import 'package:flutter/cupertino.dart';

class AuthApi {
  final _dio = DioClient.instance;

  Future<bool?> sendCodeWithEmail(String email) async {
    return await _dio.post<bool>(
      '/api/auth/email/code',
      data: {'email': email, 'type': 'login'},
    );
  }

  Future<Map<String, dynamic>?> loginWithEmail(
      String email, String code) async {
    return await _dio.post<Map<String, dynamic>>(
      '/api/auth/login/email',
      data: {
        'email': email,
        'code': code,
      },
    );
  }
}
