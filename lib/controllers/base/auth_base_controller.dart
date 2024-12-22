import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screens/auth/constants/auth_state.dart';

abstract class AuthBaseController extends GetxController {
  final _state = AuthState.initial.obs;

  AuthState get state => _state.value;

  // 状态管理方法
  void setLoading() => _state.value = AuthState.loading;
  void setSuccess() => _state.value = AuthState.success;
  void setError(String message) {
    Get.snackbar(
      '错误',
      message,
      icon: const Icon(CupertinoIcons.xmark_circle,
          color: CupertinoColors.systemRed),
    );
  }

  // 重置状态
  void resetState() {
    _state.value = AuthState.initial;
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
    } finally {
      setLoading();
    }
  }
}
