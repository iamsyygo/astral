import 'package:astral/models/api_response_models.dart';
import 'package:dio/dio.dart';

/// 响应拦截器
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 统一处理响应
    if (response.data != null && response.data is Map<String, dynamic>) {
      final responseData = ApiResponse.fromJson(response.data);

      if (!responseData.success) {
        final error = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: responseData.message,
        );
        return handler.reject(error);
      }

      // 只返回业务数据
      response.data = responseData.bizdata;
    }

    handler.next(response);
  }
}
