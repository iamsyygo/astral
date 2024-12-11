import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 自定义日志拦截器
/// 用于记录网络请求的详细信息,便于调试和问题排查
class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// 在调试模式下打印网络请求日志
    if (kDebugMode) {
      print('【网络请求】开始请求');
      print('请求方法: ${options.method}');
      print('请求地址: ${options.path}');
      print('请求头: ${options.headers}');
      print('请求参数: ${options.queryParameters}');
      print('请求数据: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 在调试模式下打印网络请求日志
    if (kDebugMode) {
      print('【网络请求】请求成功');
      print('状态码: ${response.statusCode}');
      print('请求地址: ${response.requestOptions.path}');
      print('响应数据: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /// 在调试模式下打印网络请求日志
    if (kDebugMode) {
      print('【网络请求】请求失败');
      print('错误码: ${err.response?.statusCode}');
      print('请求地址: ${err.requestOptions.path}');
      print('错误信息: ${err.message}');
    }
    super.onError(err, handler);
  }
}
