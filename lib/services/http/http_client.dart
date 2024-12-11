import 'package:astral/services/storage/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
/**
 * 隐藏 Response 类，作用：避免与 getx 的 Response 类冲突
 * 因为 getx 的 Response 类与 dio 的 Response 类冲突
 */
import 'package:get/get.dart' hide Response;

/// 标准响应格式
/// code: 状态码
/// succeed: 是否成功
/// message: 消息
/// bizdata: 业务数据
/// uri: 请求路径
/// timestamp: 时间戳

class HttpClient {
  /// 单例模式
  static final HttpClient _instance = HttpClient._internal();
  late final Dio _dio;

  /// 工厂模式
  factory HttpClient() => _instance;

  HttpClient._internal() {
    final baseOptions = BaseOptions(
      baseUrl: 'http://192.168.99.144:8030',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': Headers.jsonContentType,
        'Accept': Headers.jsonContentType,
      },
    );

    _dio = Dio(baseOptions);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleInterceptorError,
      ),
    );
  }

  void _handleRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('==================================');
    debugPrint('请求路径: ${options.path}');
    debugPrint('请求头: ${options.headers}');
    debugPrint('请求参数: ${options.data}');
    debugPrint('请求方法: ${options.method}');
    debugPrint('请求 body: ${options.data}');
    debugPrint('请求 query: ${options.queryParameters}');
    final token = Get.find<StorageService>().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  void _handleResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint('==================================');
    debugPrint('响应状态码: ${response.statusCode}');
    debugPrint('响应头: ${response.headers}');
    debugPrint('响应数据: ${response.data}');
    debugPrint('succeed: ${response.data?.succeed ?? false}');

    bool succeed = response.data?.succeed ?? false;
    if (!succeed) {
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: response.data?.message,
      ));
      return;
    }

    handler.next(response.data);
  }

  void _handleInterceptorError(
      DioException error, ErrorInterceptorHandler handler) {
    debugPrint('==================================');
    debugPrint('错误状态码: ${error.response?.statusCode}');
    debugPrint('错误数据: ${error.response?.data}');
    debugPrint('错误状态消息: ${error.response?.statusMessage}');
    _handleError(error);
    handler.reject(error);
  }

  void _handleError(DioException error) {
    String message = _getErrorMessage(error);
    Get.snackbar('错误', message);
  }

  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时';
      case DioExceptionType.receiveTimeout:
        return '响应超时';
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode);
      case DioExceptionType.cancel:
        return '请求取消';
      default:
        return '网络错误';
    }
  }

  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '未授权';
      case 403:
        return '拒绝访问';
      case 404:
        return '请求地址错误';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务不可用';
      case 505:
        return 'HTTP版本不支持';
      default:
        return '未知错误';
    }
  }

  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<T?> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }
}
