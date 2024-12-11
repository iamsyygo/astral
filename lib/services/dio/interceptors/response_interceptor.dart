import 'package:dio/dio.dart';
import '../models/api_response.dart';

/// 响应拦截器
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 统一处理响应
    if (response.data != null && response.data is Map<String, dynamic>) {
      final apiResponse = ApiResponse.fromJson(response.data);

      if (!apiResponse.succeed) {
        final error = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: apiResponse.message,
        );
        return handler.reject(error);
      }

      // 只返回业务数据
      response.data = apiResponse.bizdata;
    }

    handler.next(response);
  }
}
