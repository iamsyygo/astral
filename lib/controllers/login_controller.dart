import 'dart:async';

import 'package:get/get.dart';

import '../routes/pages.dart';
import '../services/api/auth_api.dart';
import '../services/storage/storage_service.dart';
import 'base/auth_base_controller.dart';

/// 登录控制器
/// 处理登录流程中的所有状态和业务逻辑
class LoginController extends AuthBaseController {
  final AuthApi _authApi = AuthApi();
  final StorageService _storage = Get.find<StorageService>();

  // 表单状态
  final Rx<LoginState> _loginState = LoginState().obs;
  LoginState get loginState => _loginState.value;

  // 计算属性
  bool get isValidEmail => GetUtils.isEmail(loginState.email);
  bool get canSendCode => !state.isLoading && loginState.countDown >= 60;
  bool get canSubmitCode => loginState.code.length == 6 && !state.isLoading;

  // 更新表单状态
  void updateEmail(String value) => _loginState.update((state) {
        state?.email = value;
      });

  void updateCode(String value) {
    _loginState.update((state) {
      state?.code = value;
    });
    if (value.length == 6) {
      handleLogin();
    }
  }

  // 发送验证码
  Future<void> sendEmailCode() async {
    if (!isValidEmail) {
      setError('请输入有效的邮箱地址');
      return;
    }

    final result = await handleAuthRequest(
      () => _authApi.sendCodeWithEmail(loginState.email),
    );

    if (result != null) {
      _loginState.update((state) {
        state?.currentStep = 1;
      });
      startCountDown();
      Get.toNamed(AppRoutes.verification);
    }
  }

  // 处理登录
  Future<void> handleLogin() async {
    if (!canSubmitCode) {
      // setError('请输入6位验证码');
      return;
    }

    final response = await handleAuthRequest(
      () => _authApi.loginWithEmail(
        loginState.email,
        loginState.code,
      ),
    );

    if (response != null) {
      try {
        await _storage.saveToken(response['accessToken']);
        await _storage.saveRefreshToken(response['refreshToken']);
        await _storage.setUserData(response['user']);
        Get.offAllNamed(AppRoutes.home);
      } catch (e) {
        setError('登录成功但保存用户信息失败');
      }
    }
  }

  // 退出登录
  Future<void> logout() async {
    await _storage.clearToken();
    await _storage.clearRefreshToken();
    await _storage.clearUserData();
    Get.offAllNamed(AppRoutes.login);
  }

  // 倒计时处理
  void startCountDown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (loginState.countDown == 0) {
        _loginState.update((state) {
          state?.countDown = 60;
        });
        return false;
      }
      _loginState.update((state) {
        state?.countDown--;
      });
      return true;
    });
  }

  // 重置所有状态
  void resetAll() {
    _loginState.value = LoginState();
    resetState();
  }

  @override
  void onClose() {
    resetAll();
    super.onClose();
  }
}

/// 登录状态模型
class LoginState {
  String email;
  String code;
  int currentStep;
  int countDown;

  LoginState({
    this.email = '',
    this.code = '',
    this.currentStep = 0,
    this.countDown = 60,
  });
}
