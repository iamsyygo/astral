/// API 响应模型
/// 用于统一处理后端返回的数据格式
class ApiResponse<T> {
  final int code;
  final T? bizdata;
  final String message;
  final int timestamp;
  final String uri;
  final bool success;

  ApiResponse({
    required this.code,
    this.bizdata,
    required this.message,
    required this.timestamp,
    required this.uri,
    required this.success,
  });

  /// 从 JSON 创建响应对象
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as int,
      bizdata: json['bizdata'] as T?,
      message: json['message'] as String,
      timestamp: json['timestamp'] as int,
      uri: json['uri'] as String,
      success: json['success'] as bool,
    );
  }
}
