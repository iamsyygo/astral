import 'package:get/get.dart';
import '../../screen/auth/constants/auth_state.dart';

abstract class AuthBaseController extends GetxController {
  final _state = AuthState.initial.obs;
  final _errorMessage = ''.obs;

  AuthState get state => _state.value;
  String get errorMessage => _errorMessage.value;

  // 状态管理方法
  void setLoading() => _state.value = AuthState.loading;
  void setSuccess() => _state.value = AuthState.success;
  void setError(String message) {
    _state.value = AuthState.error;
    _errorMessage.value = message;
  }

  // 重置状态
  void resetState() {
    _state.value = AuthState.initial;
    _errorMessage.value = '';
  }

  // 错误处理
  Future<T?> handleAuthRequest<T>(Future<T> Function() request) async {
    try {
      setLoading();
      final result = await request();
      setSuccess();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    }
  }
}
