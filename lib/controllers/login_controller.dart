import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/pages.dart';
import '../services/api/auth_api.dart';
import '../services/storage/storage_service.dart';

class LoginController extends GetxController {
  final _authApi = AuthApi();
  final email = ''.obs;
  final verificationCode = ''.obs;
  final isLoading = false.obs;
  final currentStep = 0.obs;

  Future<void> sendVerificationCode() async {
    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar('错误', '请输入有效的邮箱地址');
      return;
    }

    try {
      isLoading.value = true;
      final success = await _authApi.sendVerificationCode(email.value);

      if (success) {
        Get.snackbar(
          '发送成功',
          '验证码已发送至您的邮箱',
          icon: const Icon(
            CupertinoIcons.checkmark_circle,
            color: CupertinoColors.systemGreen,
          ),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        );
        currentStep.value = 1;
      } else {
        Get.snackbar('错误', '发送验证码失败');
      }
    } catch (e) {
      Get.snackbar('错误', '发送验证码失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyCode() async {
    if (verificationCode.value.length != 6) {
      Get.snackbar('错误', '请输入完整验证码');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _authApi.verifyCode(
        email.value,
        verificationCode.value,
      );
      if (response != null) {
        await Get.find<StorageService>().saveToken(response['token']);
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar('错误', '验证失败');
      }
    } catch (e) {
      Get.snackbar('错误', '验证失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onCodeChanged(String value) {
    verificationCode.value = value;
    if (value.length == 6) {
      verifyCode();
    }
  }
}
