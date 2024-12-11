import 'package:dio/dio.dart';

/// API 配置
class ApiConfig {
  /// API URL
  static const String baseUrl = 'http://192.168.99.144:8030';

  /// 超时时间（秒）
  static const Duration connectTimeout = Duration(seconds: 10);

  /// 接收超时时间（秒）
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// 请求头
  static const Map<String, dynamic> headers = {
    'Content-Type': Headers.jsonContentType,
    'Accept': Headers.jsonContentType,
  };
}
