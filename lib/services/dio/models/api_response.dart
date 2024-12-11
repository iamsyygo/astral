/// API 响应模型
/// 用于统一处理后端返回的数据格式
class ApiResponse<T> {
  final int code;
  final T? bizdata;
  final String message;
  final int timestamp;
  final String uri;
  final bool succeed;

  ApiResponse({
    required this.code,
    this.bizdata,
    required this.message,
    required this.timestamp,
    required this.uri,
    required this.succeed,
  });

  /// 从 JSON 创建响应对象
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as int,
      bizdata: json['bizdata'] as T?,
      message: json['message'] as String,
      timestamp: json['timestamp'] as int,
      uri: json['uri'] as String,
      succeed: json['succeed'] as bool,
    );
  }

  /// 创建错误响应
  factory ApiResponse.error(String message) {
    return ApiResponse(
      code: -1,
      message: message,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      uri: '',
      succeed: false,
    );
  }

  /// 判断是否成功
  bool get isSuccess => succeed && code >= 200 && code < 300;
}
