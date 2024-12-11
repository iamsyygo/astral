import 'package:get/get.dart';
import '../pages/auth/login.dart';
import '../pages/auth/verification.dart';
import '../pages/main/index.dart';

// 导入路由配置文件，包含所有路由常量定义
part 'index.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => const VerificationView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
    ),
  ];
}
