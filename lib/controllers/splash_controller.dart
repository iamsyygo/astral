import 'package:get/get.dart';
import '../services/storage/storage_service.dart';
import '../routes/pages.dart';

class SplashController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      final token = await _storage.getToken();
      final userData = await _storage.getUserData();

      if (token != null && userData != null) {
        // 有效的认证信息，直接进入首页
        await Future.delayed(const Duration(seconds: 3)); // 模拟加载时间

        Get.offAllNamed(AppRoutes.home);
      } else {
        // 无效的认证信息，进入登录页
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
