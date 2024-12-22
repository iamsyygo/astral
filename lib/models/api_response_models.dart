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

  /// 将 json 转换为 ApiResponse 对象
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

  /// 将 ApiResponse 对象转换为 json
  Map<String, dynamic> toJson() => {
        'code': code,
        'bizdata': bizdata,
        'message': message,
        'timestamp': timestamp,
        'uri': uri,
        'success': success,
      };
}
