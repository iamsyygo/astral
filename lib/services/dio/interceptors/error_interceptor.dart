import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import '../models/api_response.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = _getErrorMessage(err);
    final responseData = err.response?.data;

    DioException error = DioException(
      requestOptions: err.requestOptions,
      error: message,
      type: err.type,
      response: err.response,
    );

    if (responseData != null && responseData is Map<String, dynamic>) {
      // 请求失败的错误，直接 resolve，返回业务数据自行处理

      final data = ApiResponse.fromJson(responseData);

      Response response = Response(
        requestOptions: err.requestOptions,
        data: data.bizdata,
        statusCode: err.response?.statusCode ?? 0,
        statusMessage: err.response?.statusMessage ?? '',
      );

      Get.snackbar(
        '错误',
        data.message,
        icon: const Icon(CupertinoIcons.xmark_circle,
            color: CupertinoColors.systemRed),
      );

      // 进行 resolve 操作
      handler.resolve(response);

      // error.response?.data = data.bizdata;
      return;
    }

    handler.next(error);
  }

  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时';
      case DioExceptionType.sendTimeout:
        return '发送超时';
      case DioExceptionType.receiveTimeout:
        return '接收超时';
      case DioExceptionType.badCertificate:
        return '证书验证失败';
      case DioExceptionType.badResponse:
        return '服务器响应错误';
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.connectionError:
        return '连接错误';
      case DioExceptionType.unknown:
        return '未知错误';
    }
  }
}
