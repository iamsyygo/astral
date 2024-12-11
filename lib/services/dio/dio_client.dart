import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'config/api_config.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/token_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'models/api_response.dart';

/// DioClient 网络请求客户端
class DioClient {
  // 单例模式,全局只有一个实例
  static DioClient? _instance;

  // dio 是一个强大的 Dart Http 请求库
  // 类似于 axios
  late final Dio _dio;

  /// 私有构造函数
  /// 初始化 dio 实例和基础配置
  DioClient._() {
    // 基础配置,类似 axios.create() 的配置
    final baseOptions = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.connectTimeout,
      headers: ApiConfig.headers,
    );

    _dio = Dio(baseOptions)
      ..interceptors.addAll([
        TokenInterceptor(),
        ResponseInterceptor(),
        ErrorInterceptor(),
        LogInterceptor(),
      ]);
  }

  /// 获取单例实例时
  /// 保证全局只有一个 DioClient 实例
  static DioClient get instance => _instance ??= DioClient._();

  /// GET 请求
  /// T 是泛型,表示响应数据的类型
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters, // URL 查询参数
    Options? options, // 请求配置
    CancelToken? cancelToken, // 用于取消请求
  }) async {
    final response = await _dio.post<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data, // 请求体数据
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      return null;
    }
  }

  /// PUT 请求
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// DELETE 请求
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }
}
