import 'package:astral/services/storage/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

/// Token 拦截器
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 从本地存储获取 token
    final token = getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token 过期，处理刷新逻辑
      // refreshToken().then((newToken) {
      //   if (newToken != null) {
      //     // 使用新 token 重试请求
      //     final opts = err.requestOptions;
      //     opts.headers['Authorization'] = 'Bearer $newToken';
      //     final retry = Dio().fetch(opts);
      //     handler.resolve(retry);
      //     return;
      //   }
      //   handler.next(err);
      // });
      // return;
    }
    super.onError(err, handler);
  }

  /// 获取本地存储的 token
  String? getToken() {
    // TODO: 实现从本地存储获取 token 的逻辑
    return Get.find<StorageService>().getToken();
  }

  /// 刷新 token
  Future<String?> refreshToken() async {
    // TODO: 实现刷新 token 的逻辑
    return null;
  }
}
