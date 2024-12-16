import 'dart:async';

import 'package:get/get.dart';

import '../routes/pages.dart';
import '../services/api/auth_api.dart';
import '../services/storage/storage_service.dart';
import 'base/auth_base_controller.dart';

class LoginController extends AuthBaseController {
  final AuthApi _authApi = AuthApi();
  final StorageService _storage = Get.find<StorageService>();

  LoginController() : super();

  // 表单状态
  final email = ''.obs;
  final code = ''.obs;
  final currentStep = 0.obs;
  final countDown = 60.obs;

  // 计算属性
  bool get isValidEmail => GetUtils.isEmail(email.value);
  bool get canSendCode => !state.isLoading && countDown.value >= 60;
  bool get canSubmitCode => code.value.length == 6 && !state.isLoading;

  // 发送验证码
  Future<void> sendEmailCode() async {
    if (!isValidEmail) {
      setError('请输入有效的邮箱地址');
      return;
    }

    final result = await handleAuthRequest(
      () => _authApi.sendCodeWithEmail(email.value),
    );

    if (result != null) {
      currentStep.value = 1;
      startCountDown();
    }
  }

  // 处理登录
  Future<void> handleLogin() async {
    if (!canSubmitCode) {
      setError('请输入6位验证码');
      return;
    }

    final response = await handleAuthRequest(
      () => _authApi.loginWithEmail(
        email.value,
        code.value,
      ),
    );

    if (response != null) {
      try {
        await _storage.saveToken(response['access_token']);
        await _storage.setUserData(response['user']);
        Get.offAllNamed(AppRoutes.home);
      } catch (e) {
        setError('登录成功但保存用户信息失败');
      }
    }
  }

  // 验证码输入处理
  void onCodeChanged(String value) {
    code.value = value;
    if (value.length == 6) {
      handleLogin();
    }
  }

  // 倒计时处理
  void startCountDown() {
    countDown.value = 0;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (countDown.value >= 60) return false;
      countDown.value++;
      return true;
    });
  }

  // 重置所有状态
  void resetAll() {
    email.value = '';
    code.value = '';
    currentStep.value = 0;
    countDown.value = 60;
    resetState();
  }

  @override
  void onClose() {
    resetAll();
    super.onClose();
  }
}
