import 'package:astral/services/dio/dio_client.dart';
import 'package:astral/services/dio/models/api_response.dart';
import 'package:flutter/cupertino.dart';

class AuthApi {
  final _dio = DioClient.instance;

  Future<bool> sendVerificationCode(String email) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/user/getSigninCaptcha',
        data: {
          'email': email,
        },
      );

      debugPrint('响应数据: $response');

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> verifyCode(String email, String code) async {
    try {
      return await _dio.post<Map<String, dynamic>>(
        '/auth/verify',
        data: {
          'email': email,
          'code': code,
        },
      );
    } catch (e) {
      return null;
    }
  }
}
