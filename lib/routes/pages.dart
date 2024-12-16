import 'package:get/get.dart';
import '../screen/auth/login.dart';
import '../screen/auth/verification.dart';
import '../screen/main/index.dart';

// 导入路由配置文件，包含所有路由常量定义
part 'index.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => const VerificationScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
    ),
  ];
}
